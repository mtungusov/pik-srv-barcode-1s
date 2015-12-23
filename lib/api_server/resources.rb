require 'api_server/validator'

module Resources
  class Resource < Webmachine::Resource
    include Celluloid::Internals::Logger
  end
end

require_relative 'resources/_json'
require_relative 'resources/ping'
require_relative 'resources/topics'
require_relative 'resources/topic'
