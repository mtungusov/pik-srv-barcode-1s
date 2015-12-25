require 'settingslogic'
require_relative 'lib/settings'

$DEBUG = false
if Settings.namespace == 'development'
  require 'pry'
  $DEBUG = true
end

require 'java'
require 'celluloid/current'

$: << 'lib'
require 'api_server'
require 'json_rpc'
require 'workers'

run ApiServer::Application.adapter
Workers.start_all

%w{INT TERM QUIT}.each do |signal|
  trap(signal) do
    shutdown_app
    exit!
  end
end

def shutdown_app
  Workers.shutdown
  sleep 5
end
