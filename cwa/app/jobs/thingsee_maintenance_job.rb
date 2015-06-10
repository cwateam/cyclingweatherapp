class ThingseeMaintenanceJob < ActiveJob::Base
  queue_as :critical

  def perform(*args)
    require 'rest-firebase'    
    base_uri = 'https://glowing-inferno-7580.firebaseio.com/'

    begin
    f = RestFirebase.new :site => base_uri,
                         :secret => nil,
                         :d => {:auth_data => nil},
                         :log_method => method(:puts),
                         # `timeout` in seconds
                         :timeout => 180,
                         # `max_retries` upon failures. Default is: `0`
                         :max_retries => 3,
                         # `retry_exceptions` for which exceptions should retry
                         # Default is: `[IOError, SystemCallError]`
                         :retry_exceptions =>
                         [IOError, SystemCallError, Timeout::Error],
                         # `error_callback` would get called each time there's
                         # an exception. Useful for monitoring and logging.
                         :error_callback => method(:p),
                         # `auth_ttl` describes when we should refresh the auth
                         # token. Set it to `false` to disable auto-refreshing.
                         # The default is 23 hours.
                         :auth_ttl => 82800,
                         # `auth` is the auth token from Firebase. Leave it alone
                         # to auto-generate. Set it to `false` to disable it.
                         :auth => false # Ignore auth for this example!

    @reconnect = true

    time_now = (Time.now.to_f*1000).to_i
    t = time_now - 72 * 60 * 60 * 1000

    par = "mtime"
    
    response = f.get('thingsee_temp', :orderBy => par, :endAt => t)

    response.each { |key, value|
      f.delete("fmi_temp/#{key}")
    }

    RestFirebase.shutdown
    
    rescue
    end
    
  end
end
