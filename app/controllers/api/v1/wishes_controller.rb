module Api
  module V1
    class WishesController < ApplicationController
      def index
        render json: current_user.wishes.page(params[:page])
      end
    end
  end
end
