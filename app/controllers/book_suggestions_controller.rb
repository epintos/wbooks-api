class BookSuggestionsController < ApplicationController
  skip_before_action :authenticate_request

  def new
    @book_suggestion_list = previous_suggestions
    @book_suggestion = BookSuggestion.new
  end

  def create
    @book_suggestion = BookSuggestion.new(book_suggestion_params)
    if @book_suggestion.save
      previous_suggestions.push(@book_suggestion.attributes)
    else
      flash[:errors]  = @book_suggestion.errors.full_messages
    end
    redirect_to new_book_suggestion_path
  end

  private

  def book_suggestion_params
    params.require(:book_suggestion).permit(BookSuggestion::PERMITTED_PARAMS)
  end

  def previous_suggestions
    session[:previous_suggestions] ||= []
  end
end
