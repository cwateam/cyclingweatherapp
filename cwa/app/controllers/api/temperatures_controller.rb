module Api
  class TemperaturesController < Api::BaseController

    private

    def temperature_params
      # params.require(:artist).permit(:name)
    end

    def query_params
      # params.permit(:name)
    end

  end
end
