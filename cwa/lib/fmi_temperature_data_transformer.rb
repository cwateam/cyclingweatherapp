class FmiTemperatureDataTransformer
  def self.transform(xml_doc)
    data = Array.new
    
    xml_doc.xpath("wfs:FeatureCollection/wfs:member/omso:PointTimeSeriesObservation").each { |station|
      record = Hash.new
      # created
      record["created"] = (Time.now.to_f*1000).to_i
      
      # latitude and longitude
      l = station.xpath("om:featureOfInterest/sams:SF_SpatialSamplingFeature/sams:shape/gml:Point/gml:pos").inner_text.strip
      
      lat = (l[0..l.index(' ') - 1]).to_f
      long = (l[l.index(' ') + 1..l.length]).to_f

      record["l"] = {'0' => lat,
                     '1' => long}

      # geohash
      record["g"] = GeoHash.encode(lat, long)
      
      # mtime and temperature
      record["mtime"] = (Time.iso8601(station.xpath("om:result/wml2:MeasurementTimeseries/wml2:point/wml2:MeasurementTVP/wml2:time").last.inner_text).to_f*1000).to_i

      record["value"] = station.xpath("om:result/wml2:MeasurementTimeseries/wml2:point/wml2:MeasurementTVP/wml2:value").last.inner_text.to_f
      
      # source
      record["source"] = "fmi"

      # sensor type
      record["sensor_type"] = ""
      
      data << record
    }
    return data
  end
end
