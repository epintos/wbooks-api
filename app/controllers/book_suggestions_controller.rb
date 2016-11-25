class BookSuggestionsController < ApplicationController
  skip_before_action :authenticate_request
  def new
    render 'new'
  end
end
