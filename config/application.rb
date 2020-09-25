require_relative 'boot'

#require 'rails/all'
### OR Pick the frameworks you want
require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
#require "action_mailbox/engine"
#require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsStarterApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    
    #  Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Pacific Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :en
    
    ### Use this if you are not using logrotate
    #config.logger = ActiveSupport::Logger.new(config.paths['log'].first, 5, 5.megabyte)

    config.generators.test_framework = false
    config.generators.helper = false
    config.generators.stylesheets = false
    config.generators.javascripts = false

    config.assets.quiet = true

    config.middleware.use Rack::Deflater
    config.middleware.use Rack::Attack

    if !Rails.env.production?
      config.action_mailer.delivery_method = :smtp
      config.action_mailer.smtp_settings = { address: "localhost", port: 1025}
    end

    def build_time
      @build_time ||= File.read('BUILD_TIME').lines.first.chomp rescue 'unknown'
      @build_time ||= File.read('BUILD_TIME').lines.first.chomp.to_datetime rescue nil
    end

  end
end
