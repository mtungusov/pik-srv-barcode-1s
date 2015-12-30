class Resources::Ping < Resources::JsonResource
  def allowed_methods
    %w[GET]
  end

  def to_json
    { result: 'pong' }.to_json
  end
end
