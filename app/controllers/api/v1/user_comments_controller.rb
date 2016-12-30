module Api
  module V1
    class UserCommentsController < ApplicationController
      def index
        render json: user.comments.includes(:book).page(params[:page])
      end

      def user
        @user ||= User.find(params[:user_id])
      end
    end
  end
end
