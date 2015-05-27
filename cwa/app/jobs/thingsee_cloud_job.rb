class ThingseeCloudJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    data = ThingseeCloudData.deliver("temperature")
    if data != "error"
      base_uri = 'https://glowing-inferno-7580.firebaseio.com/'
      firebase = Firebase::Client.new(base_uri)
      
      data.each { |record|
        
        # record = ["thingseeid",
        # "latitude",
        # "longitude",
        # "mtime",
        # "temperature"]
        
        response = firebase.push("thingsee_temp", {
                                   :datatype => "temperature",
                                   :g => GeoHash.encode(record[1].to_f, record[2].to_f),
                                   :l => {:'0' => record[1].to_f,
                                          :'1' => record[2].to_f},
                                   :thingseeid => record[0],
                                   :mtime => record[3],
                                   :created => Firebase::ServerValue::TIMESTAMP,
                                   :value => record[4]
                                 })
      }
    end
  end
end
