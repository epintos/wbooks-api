class ExpiredRentMailer < ApplicationMailer
  def expired_rent(rent)
    @rent = rent
    mail to: rent.user.email, subject: "Your book rent expires tomorrow"
  end
end
