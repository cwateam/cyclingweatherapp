class FmiMaintenanceJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    base_uri = 'https://glowing-inferno-7580.firebaseio.com/'
    firebase = Firebase::Client.new(base_uri)
    response = firebase.get("fmi_temp")
    json_hash = response.body
    time_now = Time.iso8601(Time.now.utc.iso8601)
    
    json_hash.each { |key, value|
      
      mtime = Time.iso8601(value["mtime"])
      
      if mtime < time_now - (60 * 30)
        firebase.delete("fmi_temp/#{key}")
      end
    }
  end
end
