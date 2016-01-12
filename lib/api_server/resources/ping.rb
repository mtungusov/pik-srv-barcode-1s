class Resources::Ping < Resources::JsonResource
  def allowed_methods
    %w[GET]
  end

  def to_json
    _add_headers_for_swagger_editor
    { result: 'pong' }.to_json
  end
end
