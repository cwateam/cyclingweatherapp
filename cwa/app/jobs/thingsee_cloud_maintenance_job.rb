class ThingseeCloudMaintenanceJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    base_uri = 'https://glowing-inferno-7580.firebaseio.com/'
    firebase = Firebase::Client.new(base_uri)
    response = firebase.get("thingsee_temp")
    json_hash = response.body
    time_now = (Time.now.to_f*1000).to_i

    json_hash.each { |key, value|
      firebase.delete("thingsee_temp/#{key}") if value["mtime"] < (time_now - 30*60*1000)
    }
  end
end
