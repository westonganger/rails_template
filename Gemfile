source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.0'

gem 'rails', '~> 6.0.0.beta3'

### Databases
#gem 'mysql2'
gem 'pg'
gem 'marginalia' # Add application, controller, and action names as a comment at the end of each query., https://github.com/basecamp/marginalia
#gem 'fog' # Cloud services library
#gem 'scenic' # ActiveRecord::Migration methods to manage database views, https://github.com/scenic-views/scenic
#gem 'multiverse' # Manage multiple databases, https://github.com/ankane/multiverse
#gem 'rails_event_store' # https://railseventstore.org/docs/install/
#gem 'her' # models powered by a RESTful API instead of a database, https://github.com/remiprev/her

### Webservers
#gem 'puma'
#gem 'puma_worker_killer' # https://github.com/schneems/puma_worker_killer
gem 'passenger'

### Performance Enhancements
gem 'bootsnap', '>= 1.4.1', require: false
gem 'fast_blank'
gem 'fast_underscore'
#gem 'columns_on_demand' # https://github.com/willbryant/columns_on_demand
gem 'oj'
#gem 'fast_jsonapi' # https://github.com/Netflix/fast_jsonapi
#gem 'parallel'
#gem 'light_record', git: 'https://github.com/paxa/light_record.git' # load stripped down activerecord objects. Works really well for expensive reports

### Controllers
gem 'responders'
gem 'pagy' # pagination, https://github.com/ddnexus/pagy

### Users
gem 'devise'
gem 'devise_invitable' # user invitations
gem 'rolify' # user roles, https://github.com/RolifyCommunity/rolify
gem 'cancancan' # authorization, preferred
gem 'pretender' # add ability to switch user, https://github.com/ankane/pretender

### Models / Data
#gem 'active_record_union' # https://github.com/brianhempel/active_record_union
gem 'normalizr' # convert blanks to nil, strip text columns, https://github.com/dmeremyanin/normalizr
gem 'search_cop'
#gem 'friendly_id'
#gem 'paper_trail' # model versioning
#gem 'activerecord-import' ### if Rails 6 insert_all isnt enough
gem 'database_validations' # validates_db_uniqueness_of & db_belongs_to, https://github.com/toptal/database_validations
#gem 'enkrip' # automatically encrypt & decrypt Active Record attributes, https://github.com/kuntoaji/enkrip
#gem 'deep_cloneable' # clone AR records and associations, https://github.com/moiristo/deep_cloneable
 
### Views / HTML Builders
gem 'slim'
gem 'slim-rails'
gem 'simple_form'
gem 'sexy_form', github: 'westonganger/sexy_form.rb'
gem 'cocoon'
#gem 'render_async' # https://github.com/renderedtext/render_async
#gem 'phrasing' # Phrasing is a gem for live editing phrases (copy) on websites, https://github.com/infinum/phrasing
#gem 'best_in_place'

### Emails
gem 'premailer-rails' # styled emails
gem 'mjml-rails' # emails template language, https://github.com/sighmon/mjml-rails

### Utility
gem 'ice_nine', require: ['ice_nine', 'ice_nine/core_ext/object'] # provides the .deep_freeze method
#gem 'nokogiri' # basic web crawling/scraping
#gem 'watir' # web crawling with ability to interact with JS

### Payments / Store
#gem 'active_merchant'

### File Uploads
gem 'image_processing', '~> 1.2'
gem 'remotipart'
#gem 'clamby' # ClamAV scanning, https://github.com/kobaltz/clamby

### Charts
#gem 'chartkick'
#gem 'lazy_highcharts'

### Assets Helpers
gem 'sassc-rails'
gem 'jbuilder', '~> 2.5'
gem 'webpacker', '>= 4.0.0.rc.3'
gem 'autoprefixer-rails'
gem 'image_optim_rails' # https://github.com/toy/image_optim_rails
gem 'image_optim_pack'

### Export
#gem 'spreadsheet_architect'
#gem 'axlsx', git: 'https://github.com/randym/axlsx.git', ref: 'c8ac844' ### to get rid of Ruby 2.4+ deprecation errors
#gem 'prawn-rails' # native PDF generation
#gem 'squid' # Add ability to create charts in Prawn PDFs, https://github.com/fullscreen/squid
#gem 'rails_pdf' # Create PDF documents from HTML, CSS and JS.
#gem 'wicked_pdf' # html to generate pdf, https://github.com/mileszs/wicked_pdf
#gem 'rubyzip' # https://github.com/rubyzip/rubyzip

### CSS Libraries
#gem 'bootstrap-sass'
#gem 'bh' # bootstrap helpers, https://github.com/fullscreen/bh
#gem 'font-awesome-rails', '~>4.0'

### Javascript Libraries
gem 'turbolinks', '~> 5.0'
gem "databound" # access Rails model in JS, https://github.com/Nedomas/databound
gem 'client_side_validations' # https://github.com/DavyJonesLocker/client_side_validations
gem 'client_side_validations-simple_form' # https://github.com/DavyJonesLocker/client_side_validations-simple_form

### SEO / Analytics / The Little Things
gem 'metamagic'
gem 'sitemap_generator'
gem 'gaffe' ### think about your error pages
gem 'notable' # https://github.com/ankane/notable

### Engines
#gem 'fastentry' # Cache management interface

#gem 'ahoy_matey' ### https://github.com/ankane/ahoy
#gem 'app_perf_rpm' ### https://github.com/randy-girard/app_perf
#gem 'slowpoke' # Rack::Timeout enhancements for Rails, https://github.com/ankane/slowpoke

### Security
gem 'invisible_captcha'
gem 'rack-attack'

gem 'exception_notification'

group :production do
  gem 'whenever', require: false # cron job integration, `whenever --update-crontab`, https://github.com/javan/whenever
  gem 'rack-ssl-enforcer'
end

group :development, :test do
  gem 'byebug'
end

group :development do
  gem 'thin' # less errors than puma in development

  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'guard-rails'
  gem 'guard-consistency_fail'
  #gem 'guard-livereload'

  gem 'binding_of_caller'
  gem 'better_errors'
  gem 'web-console', '>= 3.3.0'

  gem 'rack-mini-profiler'
  gem 'bullet'

  ### Engines
  gem 'maily' # Preview email templates, https://github.com/markets/maily

  ### Tools / Scripts
  gem 'bundler-audit'# bundle audit check --update
  gem 'lol_dba' # bundle exec rake db:find_indexes
  gem 'derailed_benchmarks' # bundle exec derailed bundle:mem
  gem 'database_consistency' # bundle exec database_consistency
  gem 'brakeman' # bundle exec brakeman 
  gem 'active_record-annotate' # bundle exec rake db:annotate
  gem 'annotate_gemfile' # bundle exec annotate_gemfile
  gem 'rename' # rails g rename:into New-Name
  gem 'rails-erd' # generate ERD diagrams
  gem 'fix-db-schema-conflicts'

  gem 'capistrano'
  gem 'airbrussh'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-rbenv'
  gem 'capistrano-secrets-yml'
  gem 'capistrano-postgresql'
  gem 'capistrano-rbenv-install'
  gem 'capistrano-safe-deploy-to'
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
