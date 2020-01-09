class Notification < ApplicationRecord
  delegate :increment_unread_notifications, to: :to, prefix: :user
  delegate :decrement_unread_notifications, to: :to, prefix: :user

  after_create :user_increment_unread_notifications
  after_update :user_reset_unread_notifications, if: :read_changed?
  after_destroy :user_decrement_unread_notifications

  validates :reason, :to_id, :action_id, :action_type, presence: true
  validates :read, inclusion: { in: [true, false] }

  belongs_to :from, class_name: User.name
  belongs_to :to, class_name: User.name
  belongs_to :action, polymorphic: true

  scope :read, -> { where(read: true) }
  scope :unread, -> { where(read: false) }

  enum reason: {
    created: 0,
    updated: 1
  }

  def user_reset_unread_notifications
    # If read is currently true, then we need to decrement
    if read
      user_decrement_unread_notifications
    else
      user_increment_unread_notifications
    end
  end
end
