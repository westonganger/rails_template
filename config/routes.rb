Rails.application.routes.draw do
  devise_for :users
  #mount_devise_token_auth_for 'User', at: 'auth', as: :api_user

  namespace :admin do
    get 'login', to: 'sessions#new', as: :login
    post 'login', to: 'sessions#create'
    get 'logout', to: 'sessions#destroy', as: :logout
    delete 'logout', to: 'sessions#destroy'
    resource :account, only: [:edit, :update]

    root to: 'dashboard#index'
  end

  mount Sidekiq::Web => '/sidekiq'
  mount Blazer::Engine, at: "/blazer"

  require "fastentry/engine"
  mount Fastentry::Engine, at: "/cache_manager"

  #mount ActionCable.server => '/cable'

  get '/robots.txt', to: 'front_end#robots'

  root to: 'front_end#index'
end
