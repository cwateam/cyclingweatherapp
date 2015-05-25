class FmiJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # Do something later
    puts "hello world x) mac is best!"
  end
end
