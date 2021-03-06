class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :first_name, :last_name, :rents_counter, :comments_counter, presence: true
  validates :locale, inclusion: %w[en es]

  has_many :rents, dependent: :destroy
  has_many :book_suggestions, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :wishes, dependent: :destroy
  has_many :books, through: :wishes
  mount_uploader :image, ImageUploader
  has_many :notifications, foreign_key: :to_id, dependent: :destroy

  # Hooks
  before_validation :generate_verification_code, on: :create

  def generate_verification_code
    self.verification_code = AuthenticableEntity.verification_code
  end

  def increment_unread_notifications
    User.increment_counter(:unread_notifications_count, id)
  end

  def decrement_unread_notifications
    User.decrement_counter(:unread_notifications_count, id)
  end

  def reset_unread_notifications
    update(unread_notifications_count: 0)
  end
end
