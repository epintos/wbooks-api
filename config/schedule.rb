set :environment, 'development'

set :env_path,    '"$HOME/.rbenv/shims":"$HOME/.rbenv/bin"'

job_type :runner, %q{ cd :path && PATH=:env_path:"$PATH" bin/rails runner -e :environment ':task' :output }

every 1.day, at: '12:00 pm' do
  runner 'ExpiredRentWorker.perform_async'
end
