class FmiDatum
  def self.deliver(type)
    begin
      if type == "temperature"
        apikey = ENV["FMI_APIKEY"]
        start_time = (Time.now - 1.hours).utc.iso8601
        bbox = "19,59,32,70"
        query = "http://data.fmi.fi/fmi-apikey/" + apikey + "/wfs?request=getFeature&storedquery_id=fmi::observations::weather::timevaluepair&bbox=" + bbox + "&parameters=temperature&starttime=" + start_time
        response = HTTParty.get(query, timeout: 180)
        xml_doc = Nokogiri::XML(response.body)
        data = Array.new
        
        xml_doc.xpath("wfs:FeatureCollection/wfs:member/omso:PointTimeSeriesObservation").each { |station|
          # record = [####"fmisid",
          # "latitude",
          # "longitude",
          # "mtime",
          # "temperature",
          ###### "location",
          # "source (=fmi)"]
          
          record = Array.new
          
          # fmisid
          # record << station.xpath("om:featureOfInterest/sams:SF_SpatialSamplingFeature/sam:sampledFeature/target:LocationCollection/target:member/target:Location/gml:identifier").inner_text
 
          # latitude and longitude
          lal = station.xpath("om:featureOfInterest/sams:SF_SpatialSamplingFeature/sams:shape/gml:Point/gml:pos").inner_text.strip
          record << (lal[0..lal.index(' ') - 1]).to_f
          record << (lal[lal.index(' ') + 1..lal.length]).to_f

          # mtime and temperature
          record << (Time.iso8601(station.xpath("om:result/wml2:MeasurementTimeseries/wml2:point/wml2:MeasurementTVP/wml2:time").last.inner_text).to_f*1000).to_i
          record << station.xpath("om:result/wml2:MeasurementTimeseries/wml2:point/wml2:MeasurementTVP/wml2:value").last.inner_text.to_f
          # location
          #record << station.xpath("om:featureOfInterest/sams:SF_SpatialSamplingFeature/sam:sampledFeature/target:LocationCollection/target:member/target:Location/gml:name").first.inner_text

          #source
          record << "fmi"
          
          data << record
        }
        return data
      end
      if type == "air_quality"
      end
    rescue
      "error"
    end
  end
end
