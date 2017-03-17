class GoogleGateway
  include HTTParty
  base_uri 'https://www.googleapis.com/oauth2/v3'

  class << self
    def tokeninfo(id_token)
      get '/tokeninfo', query: { id_token: id_token } 
    end
  end
end
