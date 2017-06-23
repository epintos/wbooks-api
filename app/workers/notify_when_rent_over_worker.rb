class NotifyWhenRentOverWorker
  include Sidekiq::Worker

  def perform
    rents = Rent.where(to: Time.zone.today + 3)
    rents.find_each do |rent|
      create_notifications(rent) if rent.returned_at.nil?
    end
  end

  def create_notifications(rent)
    Notification.create(reason: :updated, body: 'The rent is about to expire',
                        action_type: rent.class.name, action_id: rent.id,
                        from: rent.user, to: rent.user)
  end
end
