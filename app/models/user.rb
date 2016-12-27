class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :first_name, :last_name, :rents_counter, :comments_counter, presence: true
  validates :locale, inclusion: %w(en es)

  has_many :rents, dependent: :destroy
  has_many :book_suggestions, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :wishes, dependent: :destroy
  mount_uploader :image, ImageUploader
  has_many :notifications, foreign_key: :user_to_id, counter_cache: true, dependent: :destroy

  # Hooks
  before_validation :generate_verification_code, on: :create

  def generate_verification_code
    self.verification_code = AuthenticableEntity.verification_code
  end

  def update_unreaded_notifications_counter
    update(
      unreaded_notifications_count: Notification.unreaded.where(user_to: self).count
    )
  end
end
