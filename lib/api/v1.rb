require_relative 'ping'

class API::AppV1 < Grape::API
  version 'v1', using: :path
  mount API::Ping

end
