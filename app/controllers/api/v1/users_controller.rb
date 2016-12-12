module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :current_user, :authenticate_request, except: [:show, :update]
      def show
        render json: current_user
      end

      def update
        if current_user.update(user_params)
          head :ok
        else
          render json: { error: current_user.errors }, status: :unprocessable_entity
        end
      end

      def create
        @user = User.new(user_params)
        if user.save
          token_data = AuthenticableEntity.generate_access_token(user)
          render json: {
            access_token: token_data[:token], renew_id: token_data[:renew_id]
          }, status: :created
        else
          render json: { error: user.errors }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:first_name, :last_name, :locale, :email, :password,
                                     :password_confirmation)
      end

      def user
        @user ||= User.find(params[:email])
      end
    end
  end
end
