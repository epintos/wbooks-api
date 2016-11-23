class BookSuggestionsController < ApplicationController
  skip_before_action :authenticate_request

  @@book_suggestion_list_persistent = []

  def new
    @book_suggestion_list = @@book_suggestion_list_persistent
    @book_suggestion = BookSuggestion.new
  end

  def create
    @book_suggestion = BookSuggestion.new(book_suggestion_params)
    if @book_suggestion.save
      book_suggestion_list
      redirect_to new_book_suggestion_path
    else
      @book_suggestion_list = @@book_suggestion_list_persistent
      render 'new'
    end
  end

  private

  def book_suggestion_params
    params.require(:book_suggestion).permit(:title, :editorial, :author, :link, :year)
  end

  def book_suggestion_list
    @@book_suggestion_list_persistent << @book_suggestion.attributes
  end
end
