require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'resque'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Cwa
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.assets.enabled = true;
    config.assets.initialize_on_precompile = false

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.autoload_paths += %W(#{config.root}/lib)
    config.active_record.raise_in_transactional_callbacks = true
    config.active_job.queue_adapter = :resque

    config.assets.paths << Rails.root.join("vendor","assets","bower_components","bootstrap-sass-official","assets","fonts")

    #config.assets.precompile = [/\A[^\/\\]+\.(css|js)$/i]

    config.assets.precompile << %r(.*.(?:eot|svg|ttf|woff)$)

    config.before_configuration do
      # Load application ENV vars and merge with existing ENV vars. Loaded here so can use values in initializers.
      # NOTE: the specified file is not in github. See config/application.example.yml for template file to insert your own apikeys into.
      # DEV NOTE: config/application.yml is available in the project's Google Drive under 'misc development files'.
      #ENV.update YAML.load_file('config/application.yml')[Rails.env] rescue {}
      
      env_file = File.join(Rails.root, 'config', 'application.yml')
      YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value.to_s
      end if File.exists?(env_file)
      
    end
    
  end
end
