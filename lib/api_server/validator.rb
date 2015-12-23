require 'kafka/permissions'

module ApiServer::Validator
  module_function

  def valid_request_body?(data)
    return false unless data.is_a? Hash
    return false if data.empty?

    true
  rescue
    false
  end

  def valid_request_data?(data)
    return false unless data.is_a? Array
    return false if data.empty?

    true
  rescue
    false
  end

  def valid_request_data_obj?(obj)
    return false unless obj.is_a? Hash
    return false if obj.empty?
    return false unless obj[:guid].is_a?(::String) || obj[:guid].is_a?(::Fixnum)

    true
  rescue
    false
  end

  def valid_request_topic?(topic)
    return false unless Kafka::Permissions.valid_topic? topic
    true
  rescue
    false
  end
end
