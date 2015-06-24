class ThingseeCloudTemperatureDataTransformer
  def self.transform(result)
    data = Array.new
    
    record = Hash.new
    # created
    record["created"] = (Time.now.to_f*1000).to_i
    
    # latitude and longitude
    lat = result['events'][0]['cause']['senses'][1]['val'] if result['events'][0]['cause']['senses'][1]
    long = result['events'][0]['cause']['senses'][2]['val'] if result['events'][0]['cause']['senses'][2]
    
    record["l"] = {'0' => lat,
                   '1' => long}
    
    # geohash
    record["g"] = GeoHash.encode(lat, long)
    
    # mtime and temperature
    record["mtime"] = result['events'][0]['timestamp'] if result['events'][0]['timestamp']
    
    record["value"] = result['events'][0]['cause']['senses'][0]['val'] if result['events'][0]['cause']['senses'][0]
    
    # source
    record["source"] = "thingsee"
    
    # sensor type
    record["sensor_type"] = "temperature"

    record.each {|entry|
      if entry.nil?
        raise "nil"
      end
    }
    
    data << record
    
    return data
  end
end
