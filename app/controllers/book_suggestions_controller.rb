class BookSuggestionsController < ApplicationController
  skip_before_action :authenticate_request
  def new
    render 'new'
  end

  private

  def book_suggestion
    @book_suggestion ||= BookSuggestion.find(params[:id])
  end
end
