require 'socket'

module Workers; end

require 'kafka/producer'
require 'workers/producer'

module Workers

  module_function

  def start_all
    producer_opts = {
        producer: {
            'bootstrap.servers' => Settings.connection.kafka,
            'client.id' => "#{IPSocket.getaddress(Socket.gethostname)}-#{Settings.client_name}"
        },
        timeout: Settings.connection.timeout_in_ms
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
    ApiServer.log_debug "Shutdown workers"
    @config.shutdown
  end

end
