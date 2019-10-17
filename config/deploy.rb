# config valid only for Capistrano 3.1
#lock '3.2.1'

set :scm, nil # to deploy from local files

set :application, 'two_becoming_one'
set :repo_url, 'git@gitlab.com:westonganger/two_becoming_one.git'
#set :repo_url, `git remote -v | grep origin | grep fetch`.split(' ')[1]

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, "/usr/share/nginx/html/#{fetch(:application)}/"

set :rails_env, "production"
set :user, "weston"
set :deploy, 'weston@westonganger.com' # no thats not an email address, its user@server.com
set :format, :pretty
set :log_level, :debug

#set :rbenv_type, :user
#set :rbenv_ruby, RUBY_VERSION
set :rbenv_type, :system
set :rbenv_custom_path, "/usr/lib/rbenv"
set :rbenv_ruby, "#{File.read('.ruby-version').strip}#{"-#{File.read('.ruby-variant').strip}" if File.exist?('.ruby-variant')}"

set :pg_database, fetch(:application)
#set :pg_user, fetch(:application)
#set :pg_ask_for_password, true

set :whenever_identifier, ->{"#{fetch(:application)}_#{fetch(:stage)}"}

# Default value for :pty is false
# set :pty, true

set :linked_files, %w{config/database.yml}
#set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :keep_releases, 3

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      #execute "sudo service nginx restart"
      execute :sudo, "passenger-config restart-app --ignore-app-not-running #{deploy_to}"
    end
  end
  after :publishing, :restart

  #before :deploy, :setup ### INSTEAD RUN cap production deploy:setup for first time install
  
  after :finishing, 'sitemap:create', 'deploy:cleanup'
end

namespace :rails do
  # Usage Notes: cap production rails:console - http://www.pablocantero.com/blog/2014/06/16/opening-a-rails-console-with-capistrano-3/
  desc 'Open a rails console `cap [staging] rails:console [server_index default: 0]`'
  task :console do
    on roles(:app) do |server|
      server_index = ARGV[2].to_i

      return if server != roles(:app)[server_index]

      puts "Opening a console on: #{host}...."

      #cmd = "ssh #{server.user}@#{host} -t 'export PATH='$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH' && cd #{fetch(:deploy_to)}current && RAILS_ENV=#{fetch(:rails_env)} bundle exec rails console'"
      cmd = "ssh #{server.user}@#{host} -t 'cd #{fetch(:deploy_to)}current && RAILS_ENV=#{fetch(:rails_env)} bundle exec rails console'"

      puts cmd

      exec cmd
    end
  end
end
