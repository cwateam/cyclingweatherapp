class ThingseeMaintenanceJob < ActiveJob::Base
  queue_as :critical

  def perform(*args)
    time_now = (Time.now.to_f*1000).to_i
    t = time_now - 72 * 60 * 60 * 1000

    fbc = FirebaseClient.new
    
    par = "mtime"
    
    response = fbc.get('data', :orderBy => par, :endAt => t)

    response.each { |key, value|
      fbc.delete("data/#{key}")
    }

    FirebaseClient.shutdown
    
  end
end
