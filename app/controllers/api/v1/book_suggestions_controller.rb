module Api
  module V1
    class BookSuggestionsController < ApplicationController
      def index
        render json: BookSuggestion.all.page(params[:page])
      end
    end
  end
end
