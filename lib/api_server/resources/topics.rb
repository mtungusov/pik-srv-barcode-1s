class Resources::Topics < Resources::JsonAuthResource
  def allowed_methods
    %w[GET]
  end

  def to_json
    _add_headers_for_swagger_editor
    {
        result: {
            data: _topics
        }
    }.to_json
  end

  private

  def _topics
    Kafka::Permissions.topics
  end
end
