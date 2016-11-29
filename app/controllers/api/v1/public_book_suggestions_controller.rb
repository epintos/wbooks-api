module Api
  module V1
    class PublicBookSuggestionsController < ApplicationController
      skip_before_action :current_user, :authenticate_request

      PERMITTED_PARAMS = [:title, :editorial, :price, :author, :link, :publisher, :year]

      def create
        suggestion = BookSuggestion.new(book_suggestion_params)
        if suggestion.save
          render json: suggestion, status: :created
        else
          render json: { error: suggestion.errors }, status: :unprocessable_entity
        end
      end

      private

      def book_suggestion
        @book_suggestion ||= BookSuggestion.find(params[:id])
      end

      def book_suggestion_params
        params.require(:book_suggestion).permit(PERMITTED_PARAMS)
      end
    end
  end
end
