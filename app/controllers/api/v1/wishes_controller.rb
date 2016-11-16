module Api
  module V1
    class WishesController < ApplicationController
      def index
        render json: current_user.wishes.page(params[:page])
      end

      def show
        render json: wish
      end

      private

      def wish
        @wish ||= current_user.wishes.find(params[:id])
      end
    end
  end
end
