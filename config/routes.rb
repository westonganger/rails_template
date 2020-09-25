Rails.application.routes.draw do

  api = ->(request){ request.subdomain == 'api'}
  not_api = ->(request){ !api.call(request) }

  is_admin = ->(request){ user_id = request.session['warden.user.user.key']&.first; User.with_role(:admin).find_by(id: user_id) if user_id }

  constraints api do
  end

  constraints not_api do
    devise_for :users

    namespace :admin do
      resources :users do
        get "enable"
        get "resend_invitation"
      end
      root to: 'dashboard#index'
    end

    get "/dashboard", to: "dashboard#index"

    constraints is_admin do
    end

    authenticate :user, ->(user){ user.has_role?(:admin) } do
      mount Blazer::Engine, at: "/admin/data_reporting"
      mount Fastentry::Engine, at: "/admin/cache_manager"
    end

    mount Sidekiq::Web => '/sidekiq'

    #mount ActionCable.server => '/cable'

    get '/robots.txt', to: 'front_end#robots'

    root to: 'front_end#index'
  end

end
