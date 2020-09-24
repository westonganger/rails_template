require 'sidekiq/web'
Sidekiq::Web.set :session_secret, Rails.application.secrets[:secret_key_base]

Sidekiq.configure_server do |config|
  config.redis = { db: ENV['SIDEKIQ_DB'].presence || '1' }
end
