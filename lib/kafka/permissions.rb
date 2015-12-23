module Kafka; end

module Kafka::Permissions
  module_function

  def valid_topic?(topic)
    return false unless topics.include? topic
    true
  rescue
    false
  end

  def topics
    @topics ||= if ENV['BARCODE_1S_ENV'] == 'development'
                  TOPICS.map { |t| "dev-#{t}" }
                else
                  TOPICS
                end
    @topics
  end

  TOPICS = %w[
    1s-references-podrazdeleniya
    1s-references-sotrudniki
  ]
end
