module Api
  module V1
    class BooksController < ApplicationController
      def index
        render json: Book.all.page(params[:page])
      end

      def show
        render json: book
      end

      private

      def book
        @book ||= Book.find(params[:id])
      end
    end
  end
end
