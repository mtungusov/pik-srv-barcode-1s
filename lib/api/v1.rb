class API::V1 < Grape::API; end

require_relative 'ping'

Dir["#{File.dirname(File.expand_path(__FILE__))}/v1/*.rb"].each do |f|
  require f
end

class API::V1 < Grape::API
  version 'v1', using: :path
  mount API::Ping
  mount API::V1::Query
  mount API::V1::Commands
end
