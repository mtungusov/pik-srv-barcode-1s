module ApiServer
  module_function

  def logger
    @logger ||= Celluloid.logger
  end

  def log_debug(message)
    logger.debug message if $DEBUG
  end

  def log_error(message)
    logger.error message
  end
end
