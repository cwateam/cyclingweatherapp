# Config valid only for current version of Capistrano. Remember to keep that version in Gemfile.
lock '3.4.0'

# Configuration documentation: http://capistranorb.com/documentation/getting-started/configuration/

# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any  hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

# role :app, %w{deploy@example.com}, my_property: :my_value
# role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# role :db,  %w{deploy@example.com}
role :app, ["#{ENV["DEPLOYMENT_SERVER_USER"]}@#{ENV["DEPLOYMENT_SERVER_IP"]}"]
role :web, ["#{ENV["DEPLOYMENT_SERVER_USER"]}@#{ENV["DEPLOYMENT_SERVER_IP"]}"]
role :db, ["#{ENV["DEPLOYMENT_SERVER_USER"]}@#{ENV["DEPLOYMENT_SERVER_IP"]}"]
role :production, ["#{ENV["DEPLOYMENT_SERVER_USER"]}@#{ENV["DEPLOYMENT_SERVER_IP"]}"]

##
# Repository settings
##

# URL to the repository
set :repo_url, 'git@github.com:cwateam/cyclingweatherapp.git'

# The subtree of the repository to deploy
set :repo_tree, 'cwa'

# Default value for :scm is :git
set :scm, :git

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# ---------------------------------------------

##
# Deployment server specific settings
##

# Deployment user on remote servers
set :user, 'deployer'

# Default value for keep_releases is 5
# set :keep_releases, 5

# Default shell environment used during command execution. Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# ---------------------------------------------

##
# Ssh settings
##

# Set encrypted ssh private key. If you want to understand this, please look for line 24 in .travis.yml. Also project wiki (/cwateam/cyclingweatherapp) on github could help: Deployment instructions -> Adding new private ssh key for auto deploys -> source.
set :ssh_options, keys: ["config/deploy_id_rsa"] if File.exist?("config/deploy_id_rsa")

# Default value for :pty is false
set :pty, true

# Default value for :format is :pretty
set :format, :pretty

# ---------------------------------------------

##
# Passenger settings. https://github.com/capistrano/passenger/
##

# Passenger restart command with sudo
set :passenger_restart_with_sudo, true

# Passenger restart command
set :passenger_restart_command, '-i passenger-config restart-app'

# ---------------------------------------------

##
# Bower settings. https://github.com/platanus/capistrano-bower
##

# Bowers target path
set :bower_target_path, ->{release_path.join('vendor/assets/')}

# ---------------------------------------------

##
# Whenever settings. https://github.com/javan/whenever
##

# Identifier for whenever. Whenever modifies crontab using schedule.rb from config directory. It's good to identify these crontab items somehow.
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

# Crontab edit only in production. We want to run jobs only in production.
set :whenever_roles, %w{production}

# ---------------------------------------------

##
# Rails settings. https://github.com/capistrano/rails/
##

set :migration_role, 'db'

# Defaults to false. If true, migrations are skipped if files in db/migrate not modified
set :conditionally_migrate, false

set :assets_roles, [:web]

# Defaults to 'assets' this should match config.assets.prefix in your rails config/application.rb
set :assets_prefix, 'assets'

# ---------------------------------------------

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# cap deploy:assets
# cap production rake:assets

# Set the post-deployment instructions here.
# Once the deployment is complete, Capistrano
# will begin performing them as described.
# To learn more about creating tasks,
# check out:
# http://capistranorb.com/

namespace :cwa do
  desc 'Make bin/rails executable for deployer'
  task :railsExe do
    on "#{ENV["DEPLOYMENT_SERVER_USER"]}@#{ENV["DEPLOYMENT_SERVER_IP"]}" do
      execute ("chmod u+x #{deploy_to}/current/bin/rails")
    end
  end
  desc 'set SECRET_KEY_BASE enviroment variable'
  task :secretKeyBase do
    on "#{ENV["DEPLOYMENT_SERVER_USER"]}@#{ENV["DEPLOYMENT_SERVER_IP"]}" do
      execute("cd #{deploy_to}/current && rake secret RAILS_ENV=production >> config/secrets.yml && touch tmp/restart.txt")
    end
  end
  desc 'run rvm cron setup'
  task :rvmCronSetup do
    on "#{ENV["DEPLOYMENT_SERVER_USER"]}@#{ENV["DEPLOYMENT_SERVER_IP"]}" do
      execute("cd #{deploy_to}/current && rvm cron setup")
    end
  end
  desc 'Assets'
  task :assets do
    on "#{ENV["DEPLOYMENT_SERVER_USER"]}@#{ENV["DEPLOYMENT_SERVER_IP"]}" do
      execute ("cd #{deploy_to}/current/ && RAILS_ENV=#{rails_env} bundle exec rake assets:clobber && RAILS_ENV=#{rails_env} bundle exec rake assets:precompile")
    end
  end
  desc 'Clobber'
  task :clobber do
    on "#{ENV["DEPLOYMENT_SERVER_USER"]}@#{ENV["DEPLOYMENT_SERVER_IP"]}" do
      execute ("cd #{deploy_to}/current && RAILS_ENV=#{rails_env} bundle exec rake assets:clobber")
    end
  end
  desc 'Migrations'
  task :migrations do
    on "#{ENV["DEPLOYMENT_SERVER_USER"]}@#{ENV["DEPLOYMENT_SERVER_IP"]}" do
      execute ("cd #{deploy_to}/current/ && rake db:migrate RAILS_ENV=#{rails_env}")
    end
  end
end

#namespace :deploy do

  #   desc 'Restart application'
  #   task :restart do
  #     on roles(:app), in: :sequence, wait: 5 do
  #       # Your restart mechanism here, for example:
  #       execute :touch, release_path.join('tmp/restart.txt')
  #     end
  #   end
  
  #   after :publishing, :restart
  
  #   after :restart, :clear_cache do
  #     on roles(:web), in: :groups, limit: 3, wait: 10 do
  #       # Here we can do anything such as:
  #       # within release_path do
  #       #   execute :rake, 'cache:clear'
  #       # end
  #     end
  #   end
#end
