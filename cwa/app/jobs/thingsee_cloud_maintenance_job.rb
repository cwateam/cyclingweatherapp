class ThingseeCloudMaintenanceJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    #not ready
  end
end
