require 'rails_helper'

describe Api::V1::BookSuggestionsController, type: :controller do
  describe  'GET #index' do
    context 'When fetching all the book suggestions'do
      let! (:book_suggestions) { create_list( :book_suggestion, 5) }
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
      let! (:book_suggestion) { create(:book_suggestion) }
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

end
