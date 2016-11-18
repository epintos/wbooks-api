require 'rails_helper'

RSpec.describe Wish, type: :model do

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:book_id) }

  subject(:wish) do
    Wish.new(
      user_id: user_id, book_id: book_id
    )
  end

  let!(:user_id) { create(:user).id }
  let!(:book_id) { create(:book).id }

  it { is_expected.to be_valid }

  describe '#create' do
    context 'When a duplicated wish is created' do
      it 'isn\'t valid' do
        wish.save!
        expect(Wish.create user_id: wish.user_id, book_id: wish.book_id ).to be_invalid
      end
    end
  end
end
