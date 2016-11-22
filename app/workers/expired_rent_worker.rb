class ExpiredRentWorker
  include Sidekiq::Worker

  def perform
    Rent.find_each do |rent|
      if rent.to == Date.tomorrow then
        ExpiredRentMailer.expired_rent(rent).deliver_later
      end
    end
  end
end
