# TODO: Change ActionController::Base
class UsersController < ActionController::Base

  def google_login
    # TODO: Remove layout key
    render layout: 'application'
  end
end
