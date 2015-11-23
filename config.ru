# bundle exec puma -e 'development' -C config/puma.rb

$: << 'lib'

# require 'pry'
require 'celluloid/current'
require 'api_server'

$DEBUG = false

run ApiServer::Application.adapter
