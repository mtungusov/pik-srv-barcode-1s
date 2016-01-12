require 'json'
require 'zlib'
require 'stringio'

module Resources
  API_AUTH_HEADER = /^Api_Auth (.*)$/.freeze
  VALID_CONTENT_TYPES = [
      "application/json",
      "gzip/json"
  ]

  class JsonResource < Resources::Resource
    def encodings_provided
      {"gzip" => :encode_gzip, "identity" => :encode_identity}
    end

    def content_types_provided
      [["application/json", :to_json]]
    end

    private

    # Всегда возвращает массив [result, error]
    def _params
      ct = request.headers["content-type"]
      return [nil, {message: "invalid content-type"}] unless _content_type_valid?(ct)
      body = request.body.to_s
      return [nil, {message: "empty body"}] if body.nil? || body.empty?

      _parse_body(ct, body)
    end

    def _content_type_valid?(content_type)
      Resources::VALID_CONTENT_TYPES.include? content_type
    end

    def _parse_body(content_type, body)
      case content_type
        when "application/json; charset=utf-8"
          _parse_json(body)
        when "gzip/json; charset=utf-8"
          _parse_gzip_json(body)
        else
          [nil, {message: "invalid content-type"}]
      end
    end

    def _parse_json(body)
      begin
        err = nil
        result = JSON.parse body, symbolize_names: true
      rescue Exception => e
        result = nil
        err = {message: e.message}
      end
      [result, err]
    end

    def _parse_gzip_json(body)
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
        err = {message: e.message}
      end
      [result, err]
    end

    def _add_headers_for_swagger_editor
      response.headers['Access-Control-Allow-Origin'] = 'http://editor.swagger.io'
      response.headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept'
    end
  end

  class JsonAuthResource < JsonResource
    def is_authorized?(authorization_header)
      if authorization_header =~ API_AUTH_HEADER
        _auth_by_session_key $1
      end
    end

    def _auth_by_session_key(session_key)
      session_key == 'qwerty'
    end
  end

end
