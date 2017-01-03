module Api
  module V1
    class BooksController < ApplicationController
      def index
        render json: Book.all.page(params[:page])
      end

      def create
        @book = Book.new(book_params)
        if book.save
          head :created
        else
          render json: { error: book.errors }, status: :unprocessable_entity
        end
      end

      def show
        render json: book, serializer: BookWithRentSerializer
      end

      def suggestions
        render json: Book.where(genre: book.genre).where.not(id: book.id)
      end

      private

      def book_params
        params.require(:book).permit(
          :editorial, :price, :author, :title, :link, :publisher, :year, :genre
        )
      end

      def book
        @book ||= Book.find(params[:id])
      end
    end
  end
end
