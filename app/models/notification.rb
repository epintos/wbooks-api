class Notification < ApplicationRecord
  Notification.inheritance_column = :type_sti

  delegate :update_notifications_counter, to: :user_to, prefix: :user

  after_create :user_update_notifications_counter
  after_save :user_update_notifications_counter, if: :read_changed?
  after_destroy :user_update_notifications_counter

  validates :type, :user_to_id, :action_type, presence: true
  validates :read, inclusion: { in: [true, false] }

  belongs_to :user_from, class_name: User
  belongs_to :user_to, class_name: User
  belongs_to :action, polymorphic: true

  scope :readed, -> { where(read: true) }
  scope :unreaded, -> { where(read: false) }

  enum type: {
    information: 0,
    book_rent: 1
  }
end
