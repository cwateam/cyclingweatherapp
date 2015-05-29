class FmiJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # fetch temeperature data from fmi and push to firebase
    data = FmiDatum.deliver("temperature")
    if data != "error"
      base_uri = 'https://glowing-inferno-7580.firebaseio.com/'
      firebase = Firebase::Client.new(base_uri)
      
      data.each { |record|
        # record = [##########"fmisid",
        # "latitude",
        # "longitude",
        # "mtime",
        # "temperature",
        ############ "location",
        # "source"]
        
        response = firebase.push("fmi_temp", {
                                   :created => Firebase::ServerValue::TIMESTAMP,
                                   :datatype => "temperature",
                                   #:fmisid => record[0],
                                   :g => GeoHash.encode(record[0], record[1]),
                                   :l => {:'0' => record[0],
                                          :'1' => record[1]},
                                   :mtime => record[2],
                                   :value => record[3],
                                   :source => record[4]
		                               #:location => record[5],
                                 })
      } 
    end
  end
end
