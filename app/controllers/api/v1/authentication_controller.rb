module Api
  module V1
    class AuthenticationController < ApplicationController
      skip_before_action :current_user, :authenticate_request,
                         except: [:refresh_token, :invalid_all]

      def token
        if authenticated_user?
          token_data = AuthenticableEntity.generate_access_token(user)
          render json: {
            access_token: token_data[:token], refresh_id: token_data[:refresh_id]
          }, status: :ok
        else
          render_error('Invalid email or password', :unauthorized)
        end
      end

      # TODO: Refactor and remove rubocop exception
      # rubocop:disable Metrics/AbcSize
      def refresh_token
        if !authentication_manager.warning_expiration_date_reached?
          render_error('Warning expiration date has not been reached', :forbidden)
        elsif !authentication_manager.valid_refresh_id?(refresh_token_params[:refresh_id])
          render_error('Invalid refresh_id', :unauthorized)
        elsif !authentication_manager.able_to_refresh?
          render_error('Access token is not valid anymore', :unauthorized)
        else
          access_token = authentication_manager.refresh_access_token(current_user)
          render json: { access_token: access_token }, status: :ok
        end
      end
      # rubocop:enable Metrics/AbcSize

      def invalidate_tokens
        current_user.generate_verification_code
        if current_user.save
          render nothing: true, status: :ok
        else
          render json: { error: 'Error invalidating all tokens' }, status: 500
        end
      end

      private

      def render_error(error_message, status)
        render json: { error: error_message }, status: status
      end

      def authenticated_user?
        user.present? && user.valid_password?(authenticate_params[:password])
      end

      def user
        @user ||= User.find_by(email: authenticate_params[:email])
      end

      def authenticate_params
        # [:email, :password].each { |param| params.require(param) }
        params.require(:authentication).permit(:email, :password)
      end

      def refresh_token_params
        params.require(:authentication).permit(:refresh_id)
      end

      def authentication_manager
        @authentication_manager ||= AuthenticationManager.new(request.headers)
      end
    end
  end
end
