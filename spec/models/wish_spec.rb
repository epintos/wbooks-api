require 'rails_helper'

RSpec.describe Wish, type: :model do
  it "should create a new wish" do
    Wish.create user_id: 1, book_id: 10
    expect(Wish.count).to eq(1)
  end

  it "should create different rows with different books" do
    Wish.create user_id: 1, book_id: 10
    Wish.create user_id: 1, book_id: 15
    expect(Wish.count).to eq(2)
  end

  it "should create different rows with different users" do
    Wish.create user_id: 1, book_id: 10
    Wish.create user_id: 2, book_id: 10
    expect(Wish.count).to eq(2)
  end

  it "shouldn't create a duplicated row" do
    Wish.create user_id: 1, book_id: 10
    Wish.create user_id: 1, book_id: 10
    expect(Wish.count).to eq(1)
  end

  it "shouldn't be valid if no user is specified" do
    expect(Wish.create book_id: 10).to_not be_valid
  end

  it "shouldn't be valid if no book is specified" do
    expect(Wish.create user_id: 1).to_not be_valid
  end
end
