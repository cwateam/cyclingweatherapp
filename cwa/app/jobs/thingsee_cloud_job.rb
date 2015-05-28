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
         :datatype => "temperature",
         :g => GeoHash.encode(record[1].to_f, record[2].to_f),
         :l => {:'0' => record[1].to_f,
                :'1' => record[2].to_f},
         :thingseeid => record[0],
         :mtime => record[3],
         :created => Firebase::ServerValue::TIMESTAMP,
         :value => record[4]
       })
    end
  end
end
