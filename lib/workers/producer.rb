require 'json'

class Workers::Producer
  include Celluloid

  def initialize(producer_options, timeout)
    @producer = Kafka::Producer.new(producer_options, timeout)
  end

  def send_message(topic, key, message)
    r, e = @producer.send_message(topic, key, message.to_json)
    puts "Error: #{e[:error]}" if e
    puts "Debug: producer sent: #{message}, offset: #{r.offset}" if r
    [r, e]
  end

  def close
    @producer.close
  end
end
