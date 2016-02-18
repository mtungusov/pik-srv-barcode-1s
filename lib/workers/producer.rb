class Workers::Producer
  include Celluloid

  # attr_reader :producer

  def initialize(options)
    @producer = Kafka::Producer.new(options[:producer], options[:timeout])
  end

  def send_message(topic, key, message)
    r, e = @producer.send_message(topic, key, message)
    puts "Error: #{e[:error]}" if e
    puts "Debug: producer sent: #{message}, offset: #{r.offset}" if r
    [r, e]
  end
end
