$: << 'lib'

require 'pry'

require 'java'
require 'celluloid/current'
require 'api_server'
require 'json_rpc'
require 'kafka'

$DEBUG = true

run ApiServer::Application.adapter
