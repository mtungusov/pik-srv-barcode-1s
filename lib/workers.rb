require 'socket'
require_relative 'kafka/producer'
require 'celluloid/current'

module Workers; end

require_relative 'workers/producer'

module Workers
  module_function

  def start_all
    producer_opts = {
        producer: {
            'bootstrap.servers' => $settings.connection.kafka,
            'client.id' => "#{$settings.app_name}-#{IPSocket.getaddress(Socket.gethostname)}"
        },
        timeout: $settings.connection.timeout_in_ms
    }
    @config ||= Celluloid::Supervision::Configuration.define([
                                                                 {
                                                                     type: Workers::Producer,
                                                                     as: :kafka_producer,
                                                                     args: [producer_opts]
                                                                 }
                                                             ])
    @config.deploy
  end

  def shutdown
    @config.shutdown
  end

end

