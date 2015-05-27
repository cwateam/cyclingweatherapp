class ThingseeCloudData
  def self.deliver(type)

    require 'rubygems'
    require 'httparty'
    require 'json'

    begin
      device_id = ENV["THINGSEE_ID"]
      device_token = ENV["THINGSEE_TOKEN"]

      if type == "temperature"
        record = Array.new

        # record = ["thingseeid",
        # "latitude",
        # "longitude",
        # "mtime",
        # "temperature"]

        result = HTTParty.get("http://api.thingsee.com/v1/events/"+device_id+"?type=sense&limit=1",
                               {
                                   :headers => { 'Content-Type' => 'application/json', 'Authorization' => device_token}

                               })
        byebug
        temperature = result['events'][0]['cause']['senses'][0]['val']
        timestamp = result['events'][0]['cause']['senses'][0]['ts']

        record << 0
        record << 60.1708
        record << 24.9375
        record << timestamp
        record << temperature

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
