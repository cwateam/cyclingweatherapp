class ThingseeCloudJob < ActiveJob::Base
  queue_as :default
  
  def perform(*args)
    # fetch temperature data from ts cloud and push to firebase
    
    record= ThingseeCloudDatum.deliver("temperature")
    
    if record != "error"
      fbc = FirebaseClient.new
      
      # record = [
      # "latitude",
      # "longitude",
      # "mtime",
      # "temperature",
      # "source"]
      
      fbc.post("data", :created => (Time.now.to_f*1000).to_i,
               :datatype => "temperature",
               :g => GeoHash.encode(record[0], record[1]),
               :l => {:'0' => record[0],
                      :'1' => record[1]},
               :mtime => record[2],
               :value => record[3],
               :source => record[4]
              )
      
      FirebaseClient.shutdown
    end
  end
end
