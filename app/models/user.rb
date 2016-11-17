class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :first_name, :last_name, presence: true

  has_many :rents
  has_many :book_suggestions

  # Hooks
  before_validation :generate_verification_code, on: :create

  def generate_verification_code
    self.verification_code = AuthenticableEntity.verification_code
  end
end
