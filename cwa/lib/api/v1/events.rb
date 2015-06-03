module API
  module V1
    class Events < Grape::API
      version 'v1'
      format :json

      resource :events do
        desc "Receive  event"
        post do
          puts "ehhehee"
        end
      end
    end
  end
end
