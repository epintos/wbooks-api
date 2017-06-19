require 'rails_helper'

describe Comment, type: :model do
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:book_id) }

  subject(:comment) do
    Comment.new(
      content: content, user_id: user_id, book_id: book_id
    )
  end

  let!(:user_id) { create(:user).id }
  let!(:book_id) { create(:book).id }
  let(:content) { Faker::Lorem.paragraph }

  it { is_expected.to be_valid }
  describe '#create' do
    let!(:comment) { create(:comment) }
    it 'has created_at' do
      expect(comment.created_at).to_not be_nil
    end
  end
end
