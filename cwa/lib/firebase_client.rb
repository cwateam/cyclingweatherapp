class FirebaseClient
  def self.new
    begin
      require 'rest-firebase'    
      base_uri = 'https://glowing-inferno-7580.firebaseio.com/'

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

      f
    rescue
      "error"
    end
  end

  def self.shutdown
    RestFirebase.shutdown
  end
end
