module Workers; end

class Workers::Producer
  include Celluloid

  attr_reader :producer, :log

  def initialize(options)
    ApiServer.log_debug "Producer starting up..."
    @producer = Kafka::Producer.new(options[:producer], options[:timeout])
  end

  def send_message(topic, key, message)
    r, e = producer.send_message(topic, key, message)
    ApiServer.log_error e[:error] if e
    ApiServer.log_debug "producer sent: #{message}, offset: #{r.offset}" if r
    [r, e]
  end
end
