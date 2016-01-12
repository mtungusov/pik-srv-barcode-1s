class Resources::Topic < Resources::JsonAuthResource
  def allowed_methods
    %w[POST]
  end

  def process_post
    topic, err = _get_topic
    data, err = _get_data unless err
    r = _process(topic, data) unless err
    result = if err
               ApiServer.log_error "Error: #{err}"
               {error: err}
             else
               {result: r}
             end
    response.body = result.to_json
    true
  end

  private

  def _process(topic, data)
    ApiServer.log_debug "Data: #{data}"
    data.inject({processed: 0}) do |acc, obj|
      acc[:processed] = acc[:processed].next if _process_one(topic, obj)
      acc
    end.merge({topic: topic})
  end

  def _process_one(topic, obj)
    ApiServer.log_debug "Obj: #{obj}"
    unless ApiServer::Validator.valid_request_data_obj?(topic, obj)
      ApiServer.log_error "Invalid obj: #{obj}"
      return false
    end
    _add_object_into(topic, obj[:guid], obj)
  rescue Exception => e
    ApiServer.log_error "_process_one: #{e.message}"
    false
  end

  def _add_object_into(topic, key, obj)
    m_key = key.to_s
    ApiServer.log_debug "Add into topic: #{topic}, key: #{m_key}, obj: #{obj}"
    _, e = Celluloid::Actor[:kafka_producer].send_message(topic, m_key, obj)
    e.nil?
  end

  def _get_data
    body, err = _params
    ApiServer.log_debug "Body: #{body}"
    return [nil, err] if err
    return [nil, {message: 'Invalid or empty body'}] unless ApiServer::Validator.valid_request_body? body
    data = body[:data]
    return [nil, {message: 'Invalid of empty data'}] unless ApiServer::Validator.valid_request_data? data
    [data, nil]
  end

  def _get_topic
    topic = request.path_info[:topic]
    return [nil, {message: 'Invalid topic name'}] unless ApiServer::Validator.valid_request_topic? topic
    [topic, nil]
  end
end
