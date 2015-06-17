class GdalJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    system("cd ~/.gdal")
  end

end