module Resources
  class Resource < Webmachine::Resource
    include Celluloid::Internals::Logger
  end
end



require_relative 'resources/_json'
require_relative 'resources/home'
require_relative 'resources/ping'
