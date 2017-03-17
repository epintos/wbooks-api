class Identity < ApplicationRecord
  validates :provider, :uid, :user_id, presence: true
  validates :uid, uniqueness: { scope: :provider }

  belongs_to :user, required: true
end
