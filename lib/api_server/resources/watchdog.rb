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
    result = if err
            err
          elsif !_command_valid?(@params.fetch('command', nil))
            { error: "not valid command" }
          else
            RESPONSE
          end
    response.body = result.to_json
    true
  end

  def _command_valid?(command)
    VALID_COMMANDS.include?(command) if command
  end

end
