class BookSuggestionMailerPreview < ActionMailer::Preview
  def new_book_suggestion_notification
    BookSuggestionMailer.new_book_suggestion_notification(BookSuggestion.last)
  end
end
