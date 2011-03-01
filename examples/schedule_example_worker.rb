require_relative 'base_worker'
require_relative 'example_worker'

# load keys, initialize worker, establish simple record connection
@env = :development # :production, :staging

# load configuration script
load File.expand_path('worker_configure.rb', File.dirname(__FILE__))

worker = ExampleWorker.new
# run the worker once
response = worker.queue
puts "SimpleWorker (queue) response = " + response.inspect
# start worker in 4 hours and schedule it to launch each 4 hours
response = worker.schedule(:start_at => Time.now.utc + 3600 * 4, :run_every => 3600 * 4)
puts "SimpleWorker (schedule) response = " + response.inspect
