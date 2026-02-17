# config/puma/production.rb

# Define your app's directory
directory '/var/www/financial-kit'

# Load the Rack application
rackup '/var/www/financial-kit/config.ru'

# Set environment
environment 'production'

# Run in background
#daemonize true

# File locations
pidfile '/var/www/financial-kit/tmp/pids/puma.pid'
state_path '/var/www/financial-kit/tmp/pids/puma.state'

# Log files
stdout_redirect '/var/www/financial-kit/log/puma.stdout.log', '/var/www/financial-kit/log/puma.stderr.log', true

# Threads (min, max)
threads 4, 16  # tweak based on CPU/RAM

# Number of worker processes (match CPU cores ideally)
workers 2

# Use UNIX socket (for reverse proxy like Nginx)
bind 'unix:///var/www/financial-kit/tmp/sockets/puma.sock'

# Preload the application before forking workers for better performance
preload_app!

# Called in the master process before forking workers
before_fork do
  require "active_record"
  ActiveRecord::Base.connection_pool.disconnect! if defined?(ActiveRecord)
end

# Called in each worker after forking
on_worker_boot do
  require "active_record"
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end
