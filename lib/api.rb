require "grape"

module API
  class AppV1 < Grape::API
    prefix 'api'
    version "v1", using: :path
    format :json
    get '/' do
      'hello, world!!!!'
    end
  end
end
