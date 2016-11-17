require 'rails_helper'

RSpec.describe Api::V1::WishesController, type: :controller do

  # it "responds successfully with an HTTP 200 status code" do
  #   get 'index'
  #   expect(response).to be_success
  #   expect(response).to have_http_status(200)
  # end

  # it "displays the user's username after successful login" do
  #   user = User.create!(email: "jdoe@hotmail.com", password: "secret", first_name: "joe", last_name: "doe")
  #   get "/login"
  #   assert_select "form.login" do
  #     assert_select "input[name=?]", "username"
  #     assert_select "input[name=?]", "password"
  #     assert_select "input[type=?]", "submit"
  #   end
  #
  #   post "/login", :email => "jdoe@hotmail.com", :password => "secret"
  #   assert_select ".header .username", :text => "jdoe@hotmail.com"
  # end
end
