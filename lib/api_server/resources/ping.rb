class Resources::Ping < Resources::JsonResource
  VALID_COMMANDS = %w[ping]

  def allowed_methods
    %w[POST]
  end

  def process_post
    data, err = _check_params
    ApiServer.logger.debug "data: #{data}" if $DEBUG
    # binding.pry
    req_id = data ? data[:id] : nil
    result = if err
               ApiServer.logger.debug "err: #{err}" if $DEBUG
               JsonRpc::Response.new(req_id, error: err)
             else
               JsonRpc::Response.new(req_id, result: 'pong')
             end
    ApiServer.logger.debug "result: #{result}" if $DEBUG

    response.body = result.to_json
    true
  end

  def _check_params
    data, err = _params
    return [nil, err] if err
    return [nil, {message: 'Invalid JSONRPC data'}] unless JsonRpc.valid_request? data
    return [nil, {message: 'Unknown command'}] until _valid_command?(data[:method])
    [data, nil]
  end

  def _valid_command?(command)
    VALID_COMMANDS.include?(command) if command
  end

end
