module Api
  class ParticulatesController < Api::BaseController

    private

    def particulate_params
      # params.require(:artist).permit(:name)
    end

    def query_params
      # params.permit(:name)
    end

  end
end
