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
    context 'When another wish is created for the same book and user' do
      let(:another_wish) { build(:wish, book: wish.book, user: wish.user) }
      before do
        wish.save!
      end
      it 'is invalid' do
       another_wish.save
       expect(another_wish).to be_invalid
      end
    end
  end
end
