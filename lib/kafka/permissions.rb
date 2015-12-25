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
    _fields(_topic(topic)).to_set == fields.to_set
  rescue
    false
  end

  def _topics
    @topics ||= TOPICS.keys.map { |t| "#{_topic_prefix}#{t}" }
  end

  def _fields(topic)
    TOPICS[topic]
  end

  def _topic(topic)
    _topic_prefix.empty? ? topic : topic[_topic_prefix.length..-1]
  end

  def _topic_prefix
    @topic_prefix ||= Settings.namespace == 'development' ? 'dev-': ''
  end

  TOPICS = {
    "1s-references-podrazdeleniya" => %i[guid name],
    "1s-references-sotrudniki" => %i[guid fullname ou barcode]
  }

end
