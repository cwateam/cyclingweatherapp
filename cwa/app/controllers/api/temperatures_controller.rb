module Api
  class TemperaturesController < Api::BaseController

    private

    def temperature_params
      params.require(:temperature).permit(:geohash, :timestamp, :type, :data)
    end

    def query_params
      params.permit(:geohash)
    end

  end
end
