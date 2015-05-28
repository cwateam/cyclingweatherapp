class ThingseeCloudJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    record= ThingseeCloudDatum.deliver("temperature")
    if record != "error"
      base_uri = 'https://glowing-inferno-7580.firebaseio.com/'
      firebase = Firebase::Client.new(base_uri)

        
        # record = ["thingseeid",
        # "latitude",
        # "longitude",
        # "mtime",
        # "temperature"]
        
        firebase.push("thingsee_temp", {
         :created => Firebase::ServerValue::TIMESTAMP,
         :datatype => "temperature",
         :g => GeoHash.encode(record[1].to_f, record[2].to_f),
         :l => {:'0' => record[1].to_f,
                :'1' => record[2].to_f},
         :mtime => record[3],
         :source => "thingsee",
         :value => record[4]
       })
    end
  end
end
