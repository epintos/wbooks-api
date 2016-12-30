module Api
  module V1
    class BookRentsController < ApplicationController
      def index
        render json: current_user.rents.where(book: book).page(params[:page])
      end

      private

      def book
        @book ||= Book.find(params[:book_id])
      end
    end
  end
end
