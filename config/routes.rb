Rails.application.routes.draw do
  devise_for :users

  # API Endpoints
  api_version(module: 'api/v1', path: { value: 'api/v1' }, defaults: { format: :json }) do
    resources :users, only: [:update, :create] do
      collection do
        resources :sessions, only: [:create] do
          collection do
            post :renew
            post :invalidate_all
          end
        end
        get :me
      end
      resources :wishes, only: [:index, :show, :create]
      resources :rents, only: [:create, :destroy, :show]
      resources :rents, only: [:index], controller: :user_rents
      resources :comments, only: [:index], controller: :user_comments
      resources :notifications, only: [:index] do
        collection do
          put :read_all
        end
        member do
          put :read
        end
      end
    end
    resources :books, only: [:index, :show, :create] do
      resources :comments, only: [:create, :index, :show, :update, :destroy]
      resources :rents, only: [:index], controller: :book_rents
      member do
        get :suggestions
      end
    end
    resources :book_suggestions, only: [:create, :index, :show]
  end

  require 'sidekiq/web'
  mount Sidekiq::Web, at: 'sidekiq'
end
