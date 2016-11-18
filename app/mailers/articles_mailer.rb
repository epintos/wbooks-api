class ArticlesMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.articles_mailer.latest.subject
  #
  def latest(current_user)
    @greeting = "Hi"
    mail to: current_user.email, subject: "I'm Bravo, Johny Bravo."
  end
end
