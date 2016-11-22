class ExpiredRentMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml

  def expired_rent(email)
    mail to: email, subject: 'Your book rent expires tomorrow'
  end
end
