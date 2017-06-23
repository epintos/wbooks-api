module Api
  module V1
    class RentsController < ApplicationController
      def show
        authorize rent
        render json: rent
      end

      # TODO: Refactor and remove rubocop exception
      # rubocop:disable Metrics/AbcSize
      def create
        @rent = Rent.new(rent_params)
        authorize rent
        rent.user.increment(:rents_counter)
        if rent.save && rent.user.save
          render json: rent, status: :created
        else
          render json: { error: rent.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        authorize rent, :destroy
        rent.destroy
        head :ok
      end

      def update
        authorize rent, :update
        rent.update(returned_at: Time.zone.today)
        head :ok
      end

      private

      def rent_params
        params.require(:rent).permit(:from, :to, :book_id, :user_id)
      end

      def rent
        @rent ||= current_user.rents.find(params[:id])
      end
    end
  end
end
