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
        @book_suggestion = current_user.book_suggestions.build(book_suggestion_params)
        if book_suggestion.save
          BookSuggestionMailer.new_book_suggestion_notification(book_suggestion).deliver_later
          head :created
        else
          render json: { error: book_suggestion.errors }, status: :unprocessable_entity
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
