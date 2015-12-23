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

end
