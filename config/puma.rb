# Puma configuration file

environment ENV.fetch('RAILS_ENV') { 'development' }

threads_count = ENV.fetch('RAILS_MAX_THREADS') { 5 }
threads threads_count, threads_count

workers ENV.fetch('WEB_CONCURRENCY') { 2 }
preload_app!

if ENV['RAILS_ENV'] == 'production'
  # Production (server)
  bind 'unix:///var/www/financial-kit/tmp/sockets/puma.sock'
  stdout_redirect '/var/log/puma.log', '/var/log/puma_error.log', true
  pidfile '/var/run/puma.pid'
else
  # Development (local)
  port ENV.fetch('PORT') { 3000 }
  # Leave logs in console so you can see them live
  pidfile 'tmp/pids/puma.pid'
end

on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end

plugin :tmp_restart
