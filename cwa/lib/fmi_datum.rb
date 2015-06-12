class FmiDatum
  def self.deliver(type)
    begin
      if type == "temperature"
        apikey = ENV["FMI_APIKEY"]
        start_time = (Time.now - 1.hours).utc.iso8601
        bbox = "19,59,32,70"
        query = "http://data.fmi.fi/fmi-apikey/" + apikey + "/wfs?request=getFeature&storedquery_id=fmi::observations::weather::timevaluepair&bbox=" + bbox + "&parameters=temperature&starttime=" + start_time
        response = HTTParty.get(query, timeout: 180) 
        return FmiTemperatureDataTransformer.transform(Nokogiri::XML(response.body))
      end
      if type == "air_quality"
      end
    rescue
      "error"
    end
  end
end
