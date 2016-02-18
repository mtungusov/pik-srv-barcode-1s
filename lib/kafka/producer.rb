require 'json'

class Kafka::Producer
  java_import org.apache.kafka.clients.producer.ProducerRecord
  java_import java.util.concurrent.TimeUnit

  KAFKA_PRODUCER = Java::OrgApacheKafkaClientsProducer::KafkaProducer
  # KAFKA_PRODUCER = Java::org.apache.kafka.clients.producer.KafkaProducer

  REQUIRED_OPTIONS = %w[
    bootstrap.servers
    client.id
    key.serializer
  ]

  KNOWN_OPTIONS = %w[
    acks
    bootstrap.servers
    client.id
    compression.type
    key.serializer
    retries
    linger.ms
    value.serializer
    serializer.class
  ]

  def initialize(producer_options={}, send_timeout_ms)
    @send_timeout = send_timeout_ms

    @producer = KAFKA_PRODUCER.new(Kafka::Helpers::create_config(_init_options(producer_options)))
    @send_method = @producer.java_method :send, [ProducerRecord]
  end

  def close
    @producer.close
  end

  def send_message(topic, key, message=nil)
    fail StandardError.new "Error: message is not String!" unless message.nil? or message.is_a?(String)
    _send_msg ProducerRecord.new(topic, key, message)
  end

  private

  def _send_msg(product_record)
    err = nil
    begin
      result = @send_method.call(product_record).get(@send_timeout, TimeUnit::MILLISECONDS)
    rescue Exception => e
      err = { error: e.message }
    end
    [result, err]
  end

  def _init_options(options)
    opts = options.dup
    opts['bootstrap.servers'] = opts.fetch('bootstrap.servers', 'localhost:9092')
    opts['client.id'] = opts.fetch('client.id', '')
    opts['key.serializer'] = opts.fetch('key.serializer', 'org.apache.kafka.common.serialization.StringSerializer')
    opts['value.serializer'] = opts.fetch('value.serializer', 'org.apache.kafka.common.serialization.StringSerializer')
    opts['acks'] = opts.fetch('acks', 'all')
    opts['retries'] = opts.fetch('retries', '0')
    opts['linger.ms'] = opts.fetch('linger.ms', '1')
    Kafka::Helpers::validated_options(opts, REQUIRED_OPTIONS, KNOWN_OPTIONS)
  end
end
