module Api
  module V1
    class UserRentsController < ApplicationController
      def index
        render json: user.rents.includes(:book).page(params[:page])
      end

      def user
        @user ||= User.find(params[:user_id])
      end
    end
  end
end
