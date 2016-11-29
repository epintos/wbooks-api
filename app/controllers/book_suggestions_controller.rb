class BookSuggestionsController < ApplicationController
  skip_before_action :authenticate_request

  def new
    @book_suggestion = BookSuggestion.new
  end
end
