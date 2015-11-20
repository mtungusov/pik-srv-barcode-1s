module ApiServer
  Application = Webmachine::Application.new do |app|
    app.routes do
      # add [], Resources::Home
      add [], Resources::Watchdog
    end

    app.configure do |config|
      config.adapter = :Rack
    end
  end
end
