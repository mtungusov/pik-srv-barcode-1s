class Resources::TopicMessage < Resources::JsonAuthResource
  def allowed_methods
    %w[DELETE]
  end

  def resource_exists?
    _, err = _get_topic
    err.nil?
  end

  def delete_resource
    topic, err = _get_topic
    guid = _get_guid unless err
    if err
      ApiServer.log_error "Error: #{err}"
      false
    else
      ApiServer.log_debug "Delete obj with key: #{guid} from topic: #{topic}"
      _process(topic, guid)
    end
  end

  def _process(topic, guid)
    key = guid.to_s
    _, err = Celluloid::Actor[:kafka_producer].send_message(topic, key, nil)
    err.nil?
  end

  def _get_topic
    topic = request.path_info[:topic]
    return [nil, {message: 'Invalid topic name'}] unless ApiServer::Validator.valid_request_topic? topic
    [topic, nil]
  end

  def _get_guid
    request.path_info[:guid]
  end

end
