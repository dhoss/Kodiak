# config/puma.rb
threads 1, 6
workers 2
pidfile "/var/www/kodiak/shared/tmp/puma/pid"
state_path "/var/www/kodiak/shared/tmp/puma/state"

on_worker_boot do
  require "active_record"
  cwd = File.dirname(__FILE__)+"/.."
  ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
  ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"] || YAML.load_file("/var/www/kodiak/shared/config/database.yml")[ENV["RAILS_ENV"]])
end
