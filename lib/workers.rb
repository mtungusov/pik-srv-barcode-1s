require 'celluloid/current'
require_relative 'kafka'

module Workers; end

require_relative 'workers/producer'

module Workers
  module_function

  def start_all
    timeout = $settings.connection.timeout_in_ms
    producer_opts = {
        'bootstrap.servers' => $settings.connection.kafka,
        'client.id' => "#{$settings.app_name}-#{Settings.namespace}-#{(1..5).map { rand 9 }.join}"
    }

    @config ||= Celluloid::Supervision::Configuration.define([
      {
         type: Workers::Producer,
         as: :kafka_producer,
         args: [producer_opts, timeout]
      }
    ])

    @config.deploy
  end

  def shutdown
    Celluloid::Actor[:kafka_producer].close
    @config.shutdown
  end
end
