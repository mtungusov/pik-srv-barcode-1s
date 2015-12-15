class Resources::Topic < Resources::JsonAuthResource
  def allowed_methods
    %w[POST]
  end

  # def to_json
  #   {
  #       result: {
  #           data: _data(_topic_name)
  #       }
  #   }.to_json
  # end

  private

  def _topic_name
    request.path_info[:topic_name]
  end

  # def _data(topic_name)
  #   [{}, {}]
  # end

  # def _offset
  #   request.query['offset'] || 0
  # end
end