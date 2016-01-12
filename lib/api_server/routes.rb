module ApiServer
  Application = Webmachine::Application.new do |app|
    app.routes do
      add ['v1', 'ping'], Resources::Ping
      add ['v1', 'topics'], Resources::Topics
      add ['v1', 'topics', :topic], Resources::Topic
      add ['v1', 'topics', :topic, :guid], Resources::TopicMessage
    end

    app.configure do |config|
      config.adapter = :Rack
    end
  end
end
