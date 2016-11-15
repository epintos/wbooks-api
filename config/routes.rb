Rails.application.routes.draw do
  devise_for :users

  # API Endpoints
  api_version(module: 'api/v1', path: { value: 'api/v1' }, defaults: { format: :json }) do
    resources :users do
      collection do
        resources :auth, controller: :authentication, only: [] do
          collection do
            post :token
            post :refresh_token
            post :invalidate_tokens
          end
        end
      end
      member do
        resources :rents, only: [:create, :destroy, :index, :show]
      end
    end
    resources :books, only: [:index, :show]
  end

  require 'sidekiq/web'
  mount Sidekiq::Web, at: 'sidekiq'
  mount PgHero::Engine, at: 'pghero'
end
