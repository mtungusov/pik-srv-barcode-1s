module ApiServer
  Application = Webmachine::Application.new do |app|
    app.routes do
      add ['ping'], Resources::Ping
      add ['topics'], Resources::Topics
    end

    app.configure do |config|
      config.adapter = :Rack
    end
  end
end
