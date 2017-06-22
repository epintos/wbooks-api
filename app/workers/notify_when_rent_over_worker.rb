class NotifyWhenRentOverWorker
  include Sidekiq::Worker

  def perform
    rents = Rent.where(to: Time.zone.today)
    rents.each do |rent|
      create_notifications(rent)
    end
  end

  def create_notifications(rent)
    rent.book.users.each do |user|
      Notification.create(reason: 3, action_type: 'end',
                          action_id: rent.id, from: rent.user, to: user)
    end
  end
end
