class Resources::Home < Resources::Resource
  def allowed_methods
    %w{GET HEAD}
  end

  def encodings_provided
    {"gzip" => :encode_gzip, "identity" => :encode_identity}
  end

  def content_types_provided
    [["text/html", :to_html]]
  end

  def to_html
    "<html><body>working</body></html>"
  end
end
