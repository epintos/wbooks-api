module Api
  module V1
    class BookRentsController < ApplicationController
      def index
        render json: book.rents.includes(:user).page(params[:page])
      end

      private

      def book
        @book ||= Book.find(params[:book_id])
      end
    end
  end
end
