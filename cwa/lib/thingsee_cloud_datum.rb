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

        # record = [
        # "latitude",
        # "longitude",
        # "mtime", (timestamp of data push to cloud)
        # "temperature",
        # "source (=thingsee)"]

        result = HTTParty.get(query,
                               {
                                   :headers => query_headers
                               })
        # TODO set up lookup so that it doesn't matter if order of data in json-response is random
        # atm lookup is dependent on order of sense data in hash; if specified data not present in hash, value is nil

        temperature = result['events'][0]['cause']['senses'][0]['val'] if result['events'][0]['cause']['senses'][0]
        latitude = result['events'][0]['cause']['senses'][1]['val'] if result['events'][0]['cause']['senses'][1]
        longitude = result['events'][0]['cause']['senses'][2]['val'] if result['events'][0]['cause']['senses'][2]
        timestamp = result['events'][0]['timestamp'] if result['events'][0]['timestamp']

        record << latitude
        record << longitude
        record << timestamp
        record << temperature
        record << 'thingsee'
        record.each {|entry|
          if entry.nil?
            raise "nil"
          end
        }

        return record
      end
      if type == "air_quality"
        record = Array.new
        return record
      end
    rescue
      "error"
    end
  end
end
