# Use this file to easily define all of your cron jobs.

set :environment, 'development'

every 1.minute do
  runner 'ExpiredRentWorker.perform_async'
end
