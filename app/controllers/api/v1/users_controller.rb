module Api
  module V1
    class UsersController < ApplicationController
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

      private

      def user_params
        params.require(:user).permit(:first_name, :last_name)
      end
    end
  end
end
