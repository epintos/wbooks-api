module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :current_user, :authenticate_request, except: [:renew, :invalidate_all]

      def create
        if authenticated_user?
          grant_access
        else
          render_error('Invalid email or password', :unauthorized)
        end
      end

      # TODO: Refactor and remove rubocop exception
      # rubocop:disable Metrics/AbcSize
      def renew
        if !authentication_manager.warning_expiration_date_reached?
          render_error('Warning expiration date has not been reached', :forbidden)
        elsif !authentication_manager.valid_renew_id?(renew_token_params[:renew_id])
          render_error('Invalid renew_id', :unauthorized)
        elsif !authentication_manager.able_to_renew?
          render_error('Access token is not valid anymore', :unauthorized)
        else
          access_token = authentication_manager.renew_access_token(current_user)
          render json: { access_token: access_token }, status: :ok
        end
      end
      # rubocop:enable Metrics/AbcSize

      def invalidate_all
        current_user.generate_verification_code
        if current_user.save
          head :ok
        else
          render json: { error: 'Error invalidating all tokens' }, status: 500
        end
      end

      def create_from_google
        token_validator = GoogleTokenValidator.new(params[:id_token])

        # Sync call to Google...
        return render_error('Invalid Google token', :unauthorized) unless token_validator.valid?

        identity_params = { provider: 'google', uid: token_validator.token_info['sub'] }
        @user = User.from_identity(identity_params, user_params: user_params_from_token(token_validator.token_info))

        if user.persisted?
          grant_access
        else
          render json: { errors: user.errors }, status: :unauthorized
        end
      end

      private

      def render_error(error_message, status)
        render json: { error: error_message }, status: status
      end

      def authenticated_user?
        user.present? && user.valid_password?(session_params[:password])
      end

      def user
        @user ||= User.find_by(email: session_params[:email])
      end

      def session_params
        params.require(:session).permit(:email, :password)
      end

      def renew_token_params
        params.require(:session).permit(:renew_id)
      end

      def authentication_manager
        @authentication_manager ||= AuthenticationManager.new(request.headers)
      end

      def user_params_from_token(token_info)
        # Not sure if this belongs to here...
        {
          first_name: token_info['given_name'],
          last_name: token_info['family_name'],
          email: token_info['email'],
          password: Devise.friendly_token.first(10),
          locale: :en
        }
      end

      def grant_access
        token_data = AuthenticableEntity.generate_access_token(user)
        render json: {
          access_token: token_data[:token], renew_id: token_data[:renew_id]
        }, status: :ok
      end
    end
  end
end
