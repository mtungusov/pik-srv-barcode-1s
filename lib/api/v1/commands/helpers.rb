module CommandsHelpers
  def commands
    ['update_podrazdeleniya']
  end

  def send_to_kafka(topic, key, message)
    Celluloid::Actor[:kafka_producer].send_message(topic, key, message)
  end
end
