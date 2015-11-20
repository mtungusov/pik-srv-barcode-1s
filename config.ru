# bundle exec puma -e 'development' -C config/puma.rb

$: << 'lib'

# require 'pry'
require 'celluloid/current'
require 'api_server'

run ApiServer::Application.adapter
