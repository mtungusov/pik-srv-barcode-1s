class Resources::Topics < Resources::JsonAuthResource
  def allowed_methods
    %w[GET]
  end

  def to_json
    {
        result: {
            data: _topics
        }
    }.to_json
  end

  private

  def _topics
    ['topic 1', 'topic 2']
  end
end
