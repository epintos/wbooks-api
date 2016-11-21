class ExpiredRentWorker
  include Sidekiq::Worker

  def perform
    Rent.all.each do |rent|
      if rent.to == Date.tomorrow then
        ExpiredRentMailer.expired_rent(rent.user.email).deliver_later
      end
    end
  end
end
