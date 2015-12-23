class Resources::Topic < Resources::JsonAuthResource
  def allowed_methods
    %w[POST]
  end

  def process_post
    data, err = _get_data
    unless err
      r, err = _process(data)
    end
    result = if err
               ApiServer.logger.error "Error: #{err}"
               { error: err }
             else
               { result: r }
             end
    response.body = result.to_json
    true
  end

  def _process(data)
    ApiServer.logger.debug "Data: #{data}" if $DEBUG
    # TODO
    # process obj from data
    # process data
    [{offset: 99}, nil]
  end

  private

  def _process_one(obj)
    ApiServer.logger.debug "Obj: #{obj}" if $DEBUG
    o, err = _check_obj(obj)
  end

  def _check_obj(obj)
    return [nil, {message: 'Empty object'}] if obj.nil?
    return [nil, {message: 'Object is not Hash'}] unless obj.is_a? Hash
  end

  def _get_data
    body, err = _params
    ApiServer.logger.debug "Body: #{body}" if $DEBUG
    return [nil, err] if err
    return [nil, {message: 'Invalid or empty body'}] unless ApiServer::Validator.valid_request_body? body
    data = body[:data]
    return [nil, {message: 'Invalid of empty data'}] unless ApiServer::Validator.valid_request_data? data
    [data, nil]
  end

  def _topic_name
    request.path_info[:topic_name]
  end
end