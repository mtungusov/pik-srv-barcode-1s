require 'webmachine'
require 'webmachine/adapters/rack'
require_relative 'api_server/logger'
require_relative 'api_server/resources'
require_relative 'api_server/routes'

module ApiServer
  class RequestLogger
    def call(*args)
      handle_event Webmachine::Events::InstrumentedEvent.new(*args)
    end

    def handle_event(event)
      request  = event.payload[:request]
      resource = event.payload[:resource]
      code     = event.payload[:code]
      uri      = URI(request.uri)

      # Translate extended HTTP verbs via the magical query parameter
      if request.method == "POST" && request.query['_method']
        method = request.query['_method']
      else
        method = request.method
      end

      ApiServer.logger.info "\"%s %s\" %d %.1fms (%s)" % [
        method, uri.path, code, event.duration, resource
      ]
    end
  end

  Webmachine::Events.subscribe('wm.dispatch', RequestLogger.new)
end
