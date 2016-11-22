class ExpiredRentWorker
  include Sidekiq::Worker

  def perform
    Rent.all.each do |rent|
      if rent.to == Date.tomorrow
        ExpiredRentMailer.expired_rent(rent.user.email).deliver_now
      end
    end
  end
end
