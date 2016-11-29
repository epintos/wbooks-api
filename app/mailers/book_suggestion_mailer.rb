class BookSuggestionMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.book_suggestion_mailer.new_book_suggestion_notification.subject
  #

  def new_book_suggestion_notification(book_suggestion)
    @book_suggestion = book_suggestion

    mail(to: book_suggestion.user.email, subject: t('book_suggestions.mailer.subject'))
  end
end
