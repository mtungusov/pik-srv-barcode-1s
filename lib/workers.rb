module Workers; end

require 'kafka/producer'
require 'workers/producer'

module Workers

  module_function

  def start_all
    producer_opts = {
        producer: {'bootstrap.servers' => $kf_con},
        timeout: 500
    }
    Workers::Producer.supervise as: :kafka_producer, args: [producer_opts]
  end

  def shutdown
    ApiServer.logger.debug "Shutdown workers" if $DEBUG
    Celluloid::Actor[:kafka_producer].terminate
  end

end