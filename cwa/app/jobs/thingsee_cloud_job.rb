class ThingseeCloudJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    puts "thingsee"
  end
end
