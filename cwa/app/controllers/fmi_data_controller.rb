class FmiDataController < ApplicationController
  def self.deliver(type)
    if type == "temperature"
      apikey = ENV["FMI_APIKEY"]
      start_time = (Time.now - 1.hours).utc.iso8601
      bbox = "19,59,32,70"
      query = "http://data.fmi.fi/fmi-apikey/" + apikey + "/wfs?request=getFeature&storedquery_id=fmi::observations::weather::timevaluepair&bbox=" + bbox + "&parameters=temperature&starttime=" + start_time
      response = HTTParty.get(query)
    end
    if type == "air_quality"
    end
  end
end

