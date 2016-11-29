module Api
  module V1
    class PublicBookSuggestionsController < ApplicationController
      skip_before_action :current_user, :authenticate_request
      def create
        @book_suggestion = BookSuggestion.new(book_suggestion_params)
        if book_suggestion.save
          render json: book_suggestion, status: :created
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
