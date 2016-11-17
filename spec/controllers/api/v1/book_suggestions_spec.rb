require 'rails_helper'

describe Api::V1::BookSuggestionsController, type: :controller do
  let! (:book_suggestions) { create_list( :book_suggestion, 5) }

  describe  'GET #index' do
    context 'When fetching all the book suggestions'do
      before do
        get :index
      end

      it 'responsen with the book suggestions json' do
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
end
