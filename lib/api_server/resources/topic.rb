class Resources::Topic < Resources::JsonAuthResource
  def allowed_methods
    %w[POST]
  end

  def process_post
    data, err = _check_params
    unless err
      r, err = _process(data)
    end
    result = if err
               ApiServer.logger.debug "Error: #{err}" if $DEBUG
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

  def _check_params
    body, err = _params
    ApiServer.logger.debug "Body: #{body}" if $DEBUG
    return [nil, err] if err
    return [nil, {message: 'Empty body'}] if body.nil?
    return [nil, {message: 'Body is not Hash'}] unless body.is_a? Hash
    return [nil, {message: 'Empty body'}] if body.empty?
    data = body[:data]
    return [nil, {message: 'Empty data'}] if data.nil?
    return [nil, {message: 'Data is not Array'}] unless data.is_a? Array
    return [nil, {message: 'Empty data'}] if data.empty?
    [data, nil]
  end

  def _topic_name
    request.path_info[:topic_name]
  end
end