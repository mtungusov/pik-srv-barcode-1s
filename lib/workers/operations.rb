module Workers
  module_function

  def update_to(topic, key_sym, data_array, flag=:update)
    result = data_array.reduce({offset: -1, processed: 0, errors: []}) do |acc, d|
      r, e = case flag
               when :update
                 Celluloid::Actor[:kafka_producer].send_message(topic, d[key_sym], d)
               when :delete
                 Celluloid::Actor[:kafka_producer].send_message(topic, d[key_sym])
             end
      if e.nil?
        acc[:offset] = r.offset
        acc[:processed] += 1
      else
        acc[:errors] << e.message
      end
      acc
    end

    result
  end

end
