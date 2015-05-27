class ThingseeCloudData
  def self.deliver(type)
    begin
      if type == "temperature"
        data = Array.new

        # record = ["thingseeid",
        # "latitude",
        # "longitude",
        # "mtime",
        # "temperature"]
        
        return data
      end
      if type == "air_quality"
        data = Array.new
        return data
      end
    rescue
      "error"
    end
  end
end
