require 'json'
require 'zlib'
require 'stringio'

module Resources
  # API_AUTH_HEADER = /^Api_Auth (.*)$/.freeze
  VALID_CONTENT_TYPES = [
      "application/json; charset=utf-8",
      "gzip/json; charset=utf-8"
  ]

  class JsonResource < Resources::Resource
    def encodings_provided
      {"gzip" => :encode_gzip, "identity" => :encode_identity}
    end

    def content_types_provided
      [["application/json; charset=utf-8", :to_json]]
    end

    private

    # Всегда возвращает массив [result, error]
    def _params
      result = [nil, nil]
      ct = request.headers["content-type"]
      return result unless Resources::VALID_CONTENT_TYPES.include? ct
      body = request.body.to_s
      return [nil, { error: "empty body" }] if body.nil? || body.empty?

      case ct
        when "application/json; charset=utf-8"
          _parse_json(body)
        when "gzip/json; charset=utf-8"
          _parse_gzip_json()
      end
    end

    def _parse_json(body)
      begin
        err = nil
        result = JSON.parse(body)
      rescue Exception => e
        result = nil
        err = { error: e.message }
      end
      [result, err]
    end

    def _parse_gzip_json(body)
      err = nil
      decoded_body, err = _decode_gzip(body)
      return [nil, err] if err
      _parse_json(decoded_body)
    end

    def _decode_gzip(body)
      begin
        err = nil
        sio = StringIO.new body
        gz = Zlib::GzipReader.new sio
        result = gz.read()
      rescue Exception => e
        sio.close
        result = nil
        err = { error: e.message }
      end
      [result, err]
    end
  end

end
