$: << 'lib'

if ENV['BARCODE_1S_ENV'] == 'development'
  require 'pry'
  $DEBUG = true
end

# TODO
# load config
# $kf_con = 'kafka.dev:9092'
$kf_con = 'kbr01dsk2.dsk2.picompany.ru:9092,kbr02dsk2.dsk2.picompany.ru:9092,kbr03dsk2.dsk2.picompany.ru:9092'

require 'java'
require 'celluloid/current'

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
