# config valid only for current version of Capistrano
lock '3.4.0'

set :repo_url, 'git@github.com:cwateam/cyclingweatherapp.git'
set :repo_tree, 'cwa'

set :ssh_options, keys: ["config/deploy_id_rsa"] if File.exist?("config/deploy_id_rsa")

set :passenger_restart_with_sudo, true
set :passenger_restart_command, '-i passenger-config restart-app'

set :bower_target_path, ->{release_path.join('vendor/assets/')}

set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

# Specify the server that Resque will be deployed on. If you are using Cap v3
# and have multiple stages with different Resque requirements for each, then
# these __must__ be set inside of the applicable config/deploy/... stage files
# instead of config/deploy.rb:
role :resque_worker, %w{deployer@46.101.185.190}
role :resque_scheduler, %w{deployer@46.101.185.190}

set :workers, { "critical" => 3, "default" => 2, "low" => 1 }

set :resque_environment_task, true

after "deploy:restart", "resque:restart"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Deployment user on remote servers
set :user, 'deployer'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

# cap deploy:assets
# cap production rake:assets

# Set the post-deployment instructions here.
# Once the deployment is complete, Capistrano
# will begin performing them as described.
# To learn more about creating tasks,
# check out:
# http://capistranorb.com/
namespace :cwa do
  desc 'Assets'
  task :assets do
    on "deployer@46.101.185.190" do
      execute ("cd #{deploy_to}/current/public/ && rm -rf assets")
      execute ("cd #{deploy_to}/current/ && bundle exec rake assets:precompile")
    end
  end
  desc 'Migrations'
  task :migrations do
    on "deployer@46.101.185.190" do
      execute ("cd #{deploy_to}/current/ && rake db:migrate RAILS_ENV=development")
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
