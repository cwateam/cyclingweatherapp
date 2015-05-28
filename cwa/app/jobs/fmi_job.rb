class FmiJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # fetch temeperature data from fmi and push to firebase
    data = FmiDatum.deliver("temperature")
    if data != "error"
      base_uri = 'https://glowing-inferno-7580.firebaseio.com/'
      firebase = Firebase::Client.new(base_uri)
      
      data.each { |record|
        # record = ["fmisid",
        # "latitude",
        # "longitude",
        # "mtime",
        # "temperature",
        # "location",
        # "source"]
        
        response = firebase.push("fmi_temp", {
                                   :created => Firebase::ServerValue::TIMESTAMP,
                                   :datatype => "temperature",
                                   #:fmisid => record[0],
                                   :g => GeoHash.encode(record[1].to_f, record[2].to_f),
                                   :l => {:'0' => record[1].to_f,
                                          :'1' => record[2].to_f},
                                   :mtime => record[3],
                                   :source => record[6],
                                   :value => record[4]
                                 })
      } 
    end
  end
end
