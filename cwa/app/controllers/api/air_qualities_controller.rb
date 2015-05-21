module Api
  class AirQualitiesController < Api::BaseController

    private

    def air_quality_params
      # params.require(:artist).permit(:name)
    end

    def query_params
      # params.permit(:name)
    end

  end
end
