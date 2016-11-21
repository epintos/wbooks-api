class WishesMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.wishes_mailer.latest.subject
  #
  def latest(email)
    @greeting = "Hi"
    mail to: email, subject: "Wishes Updates."
  end
end
