class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit
  rescue_from ActionController::ParameterMissing, with: :render_nothing_bad_req
  rescue_from ActiveRecord::RecordNotFound, with: :render_nothing_bad_req
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery with: :null_session

  private

  def set_locale
    I18n.locale = if current_user.present? && current_user.locale.present?
                    current_user.locale
                  else
                    I18n.default_locale
                  end
  end

  # Serializer methods
  def default_serializer_options
    { root: false }
  end

  def render_nothing_bad_req
    head :bad_request
  end
end
