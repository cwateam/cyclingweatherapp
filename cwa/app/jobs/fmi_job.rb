class FmiJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # fetch temeperature data from fmi and push to firebase
    data = FmiDataController.deliver("temperature")
    data.each { || }
  end
end
