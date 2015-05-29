class ThingseeCloudJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    record= ThingseeCloudDatum.deliver("temperature")
    if record != "error"
      base_uri = 'https://glowing-inferno-7580.firebaseio.com/'
      firebase = Firebase::Client.new(base_uri)

        
        # record = [
        # "latitude",
        # "longitude",
        # "mtime",
        # "temperature",
        # "thingsee"]
        
        firebase.push("thingsee_temp", {
         :created => Firebase::ServerValue::TIMESTAMP,
         :datatype => "temperature",
         :g => GeoHash.encode(record[0], record[1]),
         :l => {:'0' => record[0],
                :'1' => record[1]},
         :mtime => record[2],
         :value => record[3],
         :source => record[4]
       })
    end
  end
end
