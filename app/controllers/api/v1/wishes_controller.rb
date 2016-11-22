module Api
  module V1
    class WishesController < ApplicationController
      def index
        render json: policy_scope(Wish).page(params[:page])
      end

      def show
        authorize wish
        render json: wish
      end

      def create
        @wish = Wish.new(wish_params)
        authorize wish
        if wish.save
          head :created
        else
          render json: { error: wish.errors }, status: :unprocessable_entity
        end
      end

      private

      def wish_params
        params.require(:wish).permit(:user_id, :book_id)
      end

      def wish
        @wish ||= current_user.wishes.find(params[:id])
      end
    end
  end
end
