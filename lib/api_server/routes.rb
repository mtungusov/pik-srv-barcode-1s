module ApiServer
  Application = Webmachine::Application.new do |app|
    app.routes do
      add ['ping'], Resources::Ping
      add ['topics'], Resources::Topics
      add ['topics', :topic], Resources::Topic
      add ['topics', :topic, :guid], Resources::TopicDelete
    end

    app.configure do |config|
      config.adapter = :Rack
    end
  end
end
