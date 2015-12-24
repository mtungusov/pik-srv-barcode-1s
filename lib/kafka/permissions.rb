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
    @topics ||= if ENV['BARCODE_1S_ENV'] == 'development'
                  TOPICS.keys.map { |t| "dev-#{t}" }
                else
                  TOPICS.keys
                end
    @topics
  end

  def _fields(topic)
    TOPICS[topic]
  end

  def _topic(topic)
    if ENV['BARCODE_1S_ENV'] == 'development'
      # "dev-{topic-name}"
      topic[4..-1]
    else
      topic
    end
  end

  TOPICS = {
    "1s-references-podrazdeleniya" => %i[guid name],
    "1s-references-sotrudniki" => %i[guid fullname ou barcode]
  }

end
