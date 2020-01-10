module Api
  module V1
    class BooksController < ApplicationController
      before_action :authenticate_user!, :set_locale

      def index
        render json: BooksSearchQuery.new.query(
          genre: book_search_params[:genre],
          author: book_search_params[:author],
          title: book_search_params[:title]
        ).page(
          params[:page]
        ).per(params[:amount])
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
          :editorial, :price, :author, :title, :link, :publisher, :year, :genre, :description
        )
      end

      def book_search_params
        params.permit(:genre, :title, :author)
      end

      def book
        @book ||= Book.find(params[:id])
      end
    end
  end
end
