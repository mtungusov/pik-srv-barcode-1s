class Resources::Watchdog < Resources::JsonResource
  RESPONSE = { "message": "PONG" }
  VALID_COMMANDS = %w[ping]
  def allowed_methods
    %w[GET POST]
  end

  def to_json
    RESPONSE.to_json
  end

  def process_post
    @params, err = _params

    if $DEBUG
      ApiServer.logger.debug "params: #{@params}" if @params
      ApiServer.logger.debug "err: #{err}" if err
    end

    result = if err
            err
          elsif !_command_valid?(@params.fetch('command', nil))
            { error: "not valid command" }
          else
            RESPONSE
             end

    if $DEBUG
      ApiServer.logger.debug "result: #{result}" if result
    end

    response.body = result.to_json
    true
  end

  def _command_valid?(command)
    VALID_COMMANDS.include?(command) if command
  end

end
