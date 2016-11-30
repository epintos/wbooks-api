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

end
