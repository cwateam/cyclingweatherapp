# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# server 'example.com', user: 'deploy', roles: %w{app db web}, my_property: :my_value
# server 'example.com', user: 'deploy', roles: %w{app web}, other_property: :other_value
# server 'db.example.com', user: 'deploy', roles: %w{db}
server '46.101.185.190', user: 'deployer', roles: %w{web}

# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any  hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

# role :app, %w{deploy@example.com}, my_property: :my_value
# role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# role :db,  %w{deploy@example.com}
role :app, %w{deployer@46.101.185.190}
role :web, %w{deployer@46.101.185.190}
role :db, %w{deployer@46.101.185.190}
role :production, %w{deployer@46.101.185.190}

# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.
set :application, 'cwa'

##
# Repository settings
##

set :branch, 'master'

# ---------------------------------------------

##
# Deployment server specific settings
##

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/deployer/apps/cwa'

# ---------------------------------------------

##
# Resque settings. https://github.com/sshingler/capistrano-resque
##

# Specify the server that Resque will be deployed on. If you are using Cap v3
# and have multiple stages with different Resque requirements for each, then
# these __must__ be set inside of the applicable config/deploy/... stage files
# instead of config/deploy.rb
role :resque_worker, %w{deployer@46.101.185.190}
role :resque_scheduler, %w{deployer@46.101.185.190}

# Set Resque workers to be started in deployment server. Here you can also define "priorities" for queues (critical, default and low)
set :workers, { "critical" => 3, "default" => 2, "low" => 1 }

# Uncomment this line if your workers need access to the Rails environment
set :resque_environment_task, true

# ---------------------------------------------

after "deploy:restart", "resque:restart"

# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
#set :ssh_options, {
#      forward_agent: false,
#      auth_methods: %w(password),
#      password: 'user_deployers_password',
#      user: 'deployer'
#    }
#
# The server-based syntax can be used to override options:
# ------------------------------------
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
