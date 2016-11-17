Rails.application.routes.draw do
  devise_for :users

  # API Endpoints
  api_version(module: 'api/v1', path: { value: 'api/v1' }, defaults: { format: :json }) do
    resources :users do
      collection do
        resources :sessions, only: [:create] do
          collection do
            post :renew
            post :invalidate_all
          end
        end
      end
      member do
        resources :rents, only: [:create, :destroy, :index, :show]
      end
    end
    resources :books, only: [:index, :show]
    resources :book_suggestions, only: [:create, :index, :show]
  end

  require 'sidekiq/web'
  mount Sidekiq::Web, at: 'sidekiq'
  mount PgHero::Engine, at: 'pghero'
end
