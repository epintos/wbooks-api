class GoogleTokenValidator
  attr_reader :google_app_id, :token

  def initialize(token, google_app_id = nil)
    @token = token
    @google_app_id = google_app_id || Rails.application.secrets.google_client_id
  end

  def valid?
    token_info && token_info['aud'] == google_app_id
  end

  def token_info
    @token_info ||= GoogleGateway.tokeninfo(token).parsed_response || {}
  end
end
