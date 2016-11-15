module Api
  module V1
    class RentsController < ApplicationController
      def index
        render json: current_user.rents.page(params[:page])
      end

      def show
        render json: rent
      end

      def create
        rent = current_user.rents.build(rent_params)
        if rent.save
          head :created
        else
          render json: { error: rent.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        rent.destroy
        head :ok
      end

      private

      def rent_params
        params.require(:rent).permit(:from, :to, :book_id)
      end

      def rent
        @rent ||= current_user.rents.find(params[:id])
      end
    end
  end
end
