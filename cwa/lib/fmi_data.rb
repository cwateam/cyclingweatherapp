class FmiData
  def self.deliver(type)
    begin
      if type == "temperature"
        apikey = ENV["FMI_APIKEY"]
        start_time = (Time.now - 1.hours).utc.iso8601
        bbox = "19,59,32,70"
        query = "http://data.fmi.fi/fmi-apikey/" + apikey + "/wfs?request=getFeature&storedquery_id=fmi::observations::weather::timevaluepair&bbox=" + bbox + "&parameters=temperature&starttime=" + start_time
        response = HTTParty.get(query)
        xml_doc = Nokogiri::XML(response.body)
        data = Array.new
        xml_doc.xpath("wfs:FeatureCollection/wfs:member/omso:PointTimeSeriesObservation").map { |station|
          # record = ["fmisid",
          # "latitude",
          # "longitude",
          # "mtime",
          # "temperature"]
          record = Array.new

          # fmisid
          record << station.xpath("om:featureOfInterest/sams:SF_SpatialSamplingFeature/sam:sampledFeature/target:LocationCollection/target:member/target:Location/gml:identifier").inner_text
          
          # latitude and longitude
          lal = station.xpath("om:featureOfInterest/sams:SF_SpatialSamplingFeature/sams:shape/gml:Point/gml:pos").inner_text.strip
          record << lal[0..a.index(' ') - 1]
          record << lal[a.index(' ') + 1..a.length]

          # mtime and temperature
          record << station.xpath("om:result/wml2:MeasurementTimeseries/wml2:point/wml2:MeasurementTVP/wml2:time").last.inner_text
          record << station.xpath("om:result/wml2:MeasurementTimeseries/wml2:point/wml2:MeasurementTVP/wml2:value").last.inner_text
          data << record
        }
        data
      end
      if type == "air_quality"
      end
    rescue
      "error"
    end
  end
end

