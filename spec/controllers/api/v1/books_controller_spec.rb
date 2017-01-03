require 'rails_helper'

describe Api::V1::BooksController, type: :controller do
  include_context 'Authenticated User'
  describe 'GET #index' do
    context 'When fetching all books' do
      let!(:books) { create_list(:book, 5) }
      before do
        get :index
      end

      it 'responses with the books json' do
        expected = ActiveModel::Serializer::CollectionSerializer.new(
          books, each_serializer: BookSerializer
        ).to_json
        expect(response_body.to_json) =~ JSON.parse(expected)
        expect(response_body.count).to eq books.count
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET #show' do
    context 'When showing a book' do
      let!(:book) { create(:book) }
      before do
        get :show, params: { id: book.id }
      end

      it 'responses with the book json' do
        expect(response_body.to_json).to eq BookWithRentSerializer.new(
          book, root: false
        ).to_json
      end
    end
  end

  describe 'GET #suggestions' do
    context 'When fetching suggested books for a certain book' do
      let(:genre) { 'Faker::Book.genre' }
      let(:book) { create(:book, genre: genre) }
      let(:another_genre_book) { create(:book, genre: genre + 'another') }
      let!(:same_genre_books) { create_list(:book, 5, genre: genre) }
      before do
        get :suggestions, params: { id: book.id }
      end

      it 'responses with the book suggestions' do
        expected = ActiveModel::Serializer::CollectionSerializer.new(
          same_genre_books, each_serializer: BookSerializer
        ).to_json
        expect(response_body.to_json) =~ JSON.parse(expected)
        expect(response_body.count).to eq same_genre_books.count
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
