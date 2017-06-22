class NotifyWhenRentOverWorker
  include Sidekiq::Worker

  def perform
    rents = Rent.where(to: Time.zone.today)
    rents.find_each do |rent|
      create_notifications(rent)
    end
  end

  def create_notifications(rent)
    rent.book.users.find_each do |user|
      Notification.create(reason: :updated, action_type: rent.class.name,
                          action_id: rent.id, from: rent.user, to: user)
    end
  end
end
