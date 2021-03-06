require 'grape'
require 'grape/middleware/logger'
require 'json'

module API; end
require_relative 'api/v1'

module API
  class App < Grape::API
    use Grape::Middleware::Logger
    prefix 'api'
    format :json

    get '/' do
      { result: 'Barcode-1C API Server' }
    end

    mount API::V1
  end
end
