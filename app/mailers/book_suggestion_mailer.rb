class BookSuggestionMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.book_suggestion_mailer.new_book_suggestion_notification.subject
  #

  def new_book_suggestion_notification(book_suggestion)
    @created_at = book_suggestion.user.created_at
    @title = book_suggestion.title
    @author = book_suggestion.author
    @link = book_suggestion.link

    mail(to: book_suggestion.user.email, subject: 'Last Book Suggestions')
  end
end
