job_type :runner2, "cd :path && bundle exec rails runner -e :environment ':task' :output"

every 10.minutes do
  runner2 "FmiJob.perform_later"
end

every 60.minutes do

  runner2 "FmiMaintenanceJob.perform_later"
end

every 5.minutes do
  runner2 "ThingseeCloudJob.perform_later"
end

every 60.minutes do
  runner2 "ThingseeMaintenanceJob.perform_later"
end

every 10.minutes do

  runner2 "GdalJob.perform_later"

end


# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
