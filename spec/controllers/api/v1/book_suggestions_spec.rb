require 'rails_helper'

describe Api::V1::BookSuggestionsController, type: :controller do
  include_context 'Authenticated User'
  let!(:book_suggestion) { create(:book_suggestion) }

  describe  'GET #index' do
    context 'When fetching all the book suggestions' do
      let!(:book_suggestions) { create_list(:book_suggestion, 5) }
      before do
        get :index
      end

      it 'responses with the book suggestions json' do
        expected = ActiveModel::Serializer::CollectionSerializer.new(
          book_suggestions, each_serializer: BookSuggestionSerializer
        ).to_json
        expect(response_body.to_json) =~ JSON.parse(expected)
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET #show' do
    context 'When showing one book suggestion' do
      let!(:book_suggestion) { create(:book_suggestion) }
      before do
        get :show, params: { id: book_suggestion.id }
      end

      it 'responses with the book suggestion json' do
        expect(response_body.to_json).to eq BookSuggestionSerializer.new(
          book_suggestion, root: false
        ).to_json
      end
    end
  end

  describe 'POST #create' do
    context 'When creating a new book request' do
      let(:new_book_suggestion_attrs) { attributes_for(:book_suggestion) }
      it 'creates a new book suggestion' do
        expect do
          post :create, params: { book_suggestion: new_book_suggestion_attrs }
        end.to change { BookSuggestion.count }.by(1)
      end
      it 'responds with 201 status' do
        post :create, params: { book_suggestion: new_book_suggestion_attrs }
        expect(response).to have_http_status(:created)
      end
    end
  end
end
