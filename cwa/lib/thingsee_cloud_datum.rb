class ThingseeCloudDatum
  def self.deliver(type)

    require 'rubygems'
    require 'httparty'
    require 'json'

    begin
      #haxtoken
      token = HTTParty.post("http://api.thingsee.com/v1/accounts/login", :body => { :email => ENV["THINGSEE_CLOUD_U"], :password => ENV["THINGSEE_CLOUD_P"] }.to_json, :headers => { 'Content-Type' => 'application/json'})["accountAuthToken"]
      device_id = ENV["THINGSEE_ID"]
      device_token = "Bearer " + token
      query_base = "http://api.thingsee.com/v1/events/"+device_id+"?type=sense"
      query_headers = { 'Content-Type' => 'application/json', 'Authorization' => device_token}
      if type == "temperature"
        record = Array.new
        
        #get only the latest temperature data
        
        query = query_base+"&limit=1"
        
        result = HTTParty.get(query,
                              {
                                :headers => query_headers
                              })
        
        return ThingseeCloudTemperatureDataTransformer.transform(result)
      end
      if type == "air_quality"
      end
    rescue
      "error"
    end
  end
end
