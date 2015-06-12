class FmiJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # fetch temperature data from fmi and push to firebase
    
    data = FmiDatum.deliver("temperature")

    if data != "error"
      fbc = FirebaseClient.new
      
      data.each { |record|  
        fbc.post("data", record)
      }
      
      FirebaseClient.shutdown
    end
  end
end
