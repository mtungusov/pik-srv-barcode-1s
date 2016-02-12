require 'grape'
require 'json'

module API; end
require_relative 'api/v1'

module API
  class App < Grape::API
    prefix 'api'
    format :json

    get '/' do
      { result: 'Barcode-1C API Server' }
    end

    mount API::AppV1
  end
end
