module Workers; end

class Workers::Producer
  include Celluloid

  attr_reader :producer, :log

  def initialize(options)
    @log = ApiServer.logger
    log.debug "ProducerPandom starting up..." if $DEBUG
    @producer = Kafka::Producer.new(options[:producer], options[:timeout])
  end

  def send_message(topic, key, message)
    r, e = producer.send_message(topic, key, message)
    log.error e[:error] if e
    log.debug "producer sent: #{message}, offset: #{r.offset}" if r && $DEBUG
    [r, e]
  end

  def shutdown
    log.debug "Shuting down begin..."  if $DEBUG
    sleep 2.0
    log.debug "Shuting complete!"  if $DEBUG
  end
end
