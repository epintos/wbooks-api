class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :first_name, :last_name, presence: true
  validates :locale, inclusion: %w(en es)
  has_many :rents, dependent: :destroy
  has_many :book_suggestions, dependent: :destroy

  has_many :wishes, dependent: :destroy

  # Hooks
  before_validation :generate_verification_code, on: :create

  def generate_verification_code
    self.verification_code = AuthenticableEntity.verification_code
  end
end
