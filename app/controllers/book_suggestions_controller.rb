class BookSuggestionsController < ApplicationController
  skip_before_action :authenticate_request

  def new
    @book_suggestion = BookSuggestion.new
  end

  def create
    @book_suggestion = BookSuggestion.new(book_suggestion_params)
    if @book_suggestion.save
      redirect_to new_book_suggestion_path
    else
      render 'new'
    end
  end

  private

  def book_suggestion_params
    params.require(:book_suggestion).permit(:title, :editorial, :author, :link, :year)
  end
end
