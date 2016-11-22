module Api
  module V1
    class BookSuggestionsController < ApplicationController
      def index
        render json: BookSuggestion.all.page(params[:page])
      end

      def show
        render json: book_suggestion
      end

      def create
        suggestion = current_user.book_suggestions.build(book_suggestion_params)
        if suggestion.save
          head :created
        else
          render json: { error: suggestion.errors }, status: :unprocessable_entity
        end
      end

      private

      def book_suggestion
        @book_suggestion ||= BookSuggestion.find(params[:id])
      end

      def book_suggestion_params
        params.require(:book_suggestion).permit(
          :title, :editorial, :price, :author, :link, :publisher, :year
        )
      end
    end
  end
end
