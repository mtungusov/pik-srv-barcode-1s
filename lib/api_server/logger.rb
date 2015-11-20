module ApiServer
  def self.logger
    @logger || Celluloid.logger
  end
end
