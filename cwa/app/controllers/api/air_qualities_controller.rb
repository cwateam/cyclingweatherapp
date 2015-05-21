module Api
  class AirQualitiesController < Api::BaseController

    private

    def air_quality_params
      params.require(:temperature).permit(:geohash, :timestamp, :type, :data)
    end

    def query_params
      params.permit(:geohash)
    end

  end
end
