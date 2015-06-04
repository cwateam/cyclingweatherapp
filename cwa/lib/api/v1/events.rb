module API
  module V1
    class Events < Grape::API
      version 'v1'
      format :json

      resource :events do

        params do
          requires :senses
        end
        
        desc "Receive event"
        post do
          Rails.logger.info params.senses.to_s
        end
      end
    end
  end
end
