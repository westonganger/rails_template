Rails.application.routes.draw do

  api = ->(request){ request.subdomain == 'api'}
  not_api = ->(request){ !api.call(request) }

  constraints api do
  end

  constraints not_api do
    devise_for :users

    namespace :admin do
      get 'login', to: 'sessions#new', as: :login
      post 'login', to: 'sessions#create'
      get 'logout', to: 'sessions#destroy', as: :logout
      delete 'logout', to: 'sessions#destroy'
      resource :account, only: [:edit, :update]

      root to: 'dashboard#index'
    end

    mount Blazer::Engine, at: "/admin/data_reporting"
    mount Fastentry::Engine, at: "/admin/cache_manager"

    mount Sidekiq::Web => '/sidekiq'

    #mount ActionCable.server => '/cable'

    get '/robots.txt', to: 'front_end#robots'

    root to: 'front_end#index'
  end

end
