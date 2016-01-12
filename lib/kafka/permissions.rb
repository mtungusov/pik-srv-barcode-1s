module Kafka; end

module Kafka::Permissions
  module_function

  def valid_topic?(topic)
    return false unless _topics.include? topic
    true
  rescue
    false
  end

  def valid_topic_fields?(topic, fields)
    _fields(topic).to_set == fields.to_set
  rescue
    false
  end

  def _topics
    @topics ||= TOPICS.keys
  end

  def _fields(topic)
    TOPICS[topic]
  end

  TOPICS = {
    "1s-references-podrazdeleniya" => %i[guid name],
    "1s-references-sotrudniki" => %i[guid fullname ou barcode]
  }

end
