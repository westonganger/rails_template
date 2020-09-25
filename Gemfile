source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'rails', '~> 6.0.3'

### Databases
gem 'pg'

### Services
gem 'sidekiq'

### Webservers
gem 'puma'

### Performance Enhancements
gem 'bootsnap', require: false
gem 'fast_blank'
gem 'fast_underscore'
gem 'oj'
#gem 'fast_jsonapi' # https://github.com/Netflix/fast_jsonapi
#gem 'parallel'
#gem 'light_record', git: 'https://github.com/paxa/light_record.git' # load stripped down activerecord objects. Works really well for expensive reports

### Configuration
gem 'dotenv-rails'

### Controllers
gem 'responders'
gem 'kaminari' # pagination

### Users
gem 'devise'
gem 'devise_invitable' # user invitations
gem 'rolify' # user roles, https://github.com/RolifyCommunity/rolify
gem 'cancancan' # authorization, preferred
gem 'pretender' # add ability to switch user, https://github.com/ankane/pretender

### Models / Data
gem 'search_cop'
gem 'paper_trail' # model versioning
 
### Views / HTML Builders
gem 'slim'
gem 'slim-rails'
#gem 'simple_form'
gem 'sexy_form'
gem 'cocoon'
gem 'render_async' # https://github.com/renderedtext/render_async

### Utility
gem 'nokogiri' # basic web crawling/scraping

### File Uploads
gem 'shrine'
gem 'image_processing'
gem 'remotipart'

### Assets Helpers
gem 'sassc-rails'
gem 'mini_racer'
gem 'webpacker'
gem 'autoprefixer-rails'
gem 'premailer-rails' # styled emails
gem 'image_optim_rails' # https://github.com/toy/image_optim_rails
gem 'image_optim_pack'

### Export
gem 'spreadsheet_architect'
gem 'prawn-rails' # native PDF generation

### CSS Libraries
gem 'bootstrap-sass'

### Javascript Libraries
gem 'turbolinks', '~> 5.0'

### SEO / Analytics / The Little Things
gem 'metamagic'
gem 'sitemap_generator'

### Engines
gem 'blazer'
gem 'fastentry', require: ['fastentry','fastentry/engine'] # Cache management interface
gem 'maily' # Preview email templates, https://github.com/markets/maily

### Security
gem 'invisible_captcha'
gem 'rack-attack'

### Server
gem 'exception_notification'
gem 'whenever', require: false # cron job integration, `whenever --update-crontab`, https://github.com/javan/whenever

group :production do
end

group :development, :test do
  gem 'byebug'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'guard-rails'
  gem 'guard-consistency_fail'
  #gem 'guard-livereload'

  gem 'binding_of_caller'
  gem 'better_errors'
  gem 'web-console', '>= 3.3.0'

  #gem 'rack-mini-profiler'
  gem 'rack-mini-profiler', git: "https://github.com/westonganger/rack-mini-profiler.git", branch: "patch-1"
  gem 'bullet'

  ### Tools
  gem 'bundler-audit'# bundle audit check --update
  gem 'lol_dba' # bundle exec rake db:find_indexes
  gem 'derailed_benchmarks' # bundle exec derailed bundle:mem
  gem 'database_consistency' # bundle exec database_consistency
  gem 'brakeman' # bundle exec brakeman 
  gem 'rails-erd' # generate ERD diagrams

  ### Deployment
  gem 'capistrano'
  gem 'airbrussh'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-rbenv'
  gem 'capistrano-secrets-yml'
  gem 'capistrano-postgresql'
  #gem 'capistrano-rbenv-install'
  gem 'capistrano-safe-deploy-to'
  gem 'capistrano-precompile-chooser'
  gem 'dump' # Rails app rake and capistrano tasks to create and restore dumps of database and assets, https://github.com/toy/dump
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  #gem 'chromedriver-helper' # chrome driver
  gem 'geckodriver-helper' # firefox driver

  # gem 'undercover' # Simple test coverage reporting, https://github.com/grodowski/undercover
  # gem 'simplecov'
  # gem 'simplecov-lcov'
  gem 'covered' # `COVERAGE=PartialSummary minitest`, https://github.com/ioquatix/covered

  #gem 'minitest-rails'
  #gem "minitest-rails-capybara"
  gem 'rails-controller-testing'
  gem 'minitest-reporters', require: false
  gem 'connection_pool', require: false
  gem 'database_cleaner', require: false
end
