# Load DSL and Setup Up Stages
require 'capistrano/setup'

# Includes default deployment tasks
require 'capistrano/deploy'

#require 'capistrano/rvm'
#require 'capistrano/chruby'
require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'whenever/capistrano'
require 'capistrano/secrets_yml'
#require 'capistrano/faster_assets'
require 'capistrano/postgresql'
require 'capistrano/safe_deploy_to'
require 'capistrano/rbenv_install'
require 'capistrano/sitemap_generator'

require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.cap').each { |r| import r }
