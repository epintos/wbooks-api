class NotifyWhenRentOverWorker
  include Sidekiq::Worker

  def perform
    rents = Rent.where(to: Time.zone.today, returned_at: nil)
    rents.find_each do |rent|
      create_notifications(rent)
    end
  end

  def create_notifications(rent)
    Notification.create(reason: :updated, body: 'The rent is expired',
                        action_type: rent.class.name, action_id: rent.id,
                        from: rent.user, to: rent.user)
  end
end
