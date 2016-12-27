class Notification < ApplicationRecord
  Notification.inheritance_column = :type_sti

  after_destroy :update_counter_cache
  after_save :update_counter_cache

  validates :type, :user_to, :type, presence: true

  belongs_to :user_from, class_name: User
  belongs_to :user_to, class_name: User
  belongs_to :action, polymorphic: true

  scope :readed, -> { where(read: true) }
  scope :unreaded, -> { where(read: false) }

  enum type: {
    information: 0,
    book_rent: 1
  }

  def update_counter_cache
    user_to.update(
      unreaded_notifications_count: Notification.unreaded.where(user_to: user_to).count
    )
  end
end
