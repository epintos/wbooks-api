module Api
  module V1
    class BookSuggestionsController < ApplicationController
      def index
        render json: BookSuggestion.all.page(params[:page])
      end

      def show
        render json: book_suggestion
      end

      private

      def book_suggestion
        book_suggestion ||= BookSuggestion.find(params[:id])
      end
    end
  end
end
