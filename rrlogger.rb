module RRLogger
  def logger
    @logger ||= Logger.new STDOUT
  end

  def log_connection
    str = request_string + response_string
    logger.info str
  end

  def request_headers
    env.select { |k, _v| k.match /^HTTP_/ }
      .map { |k, v| { k.sub('HTTP_', '') => v } }
      .inject({}) { |a, e| a.merge e }
  end

  def request_string
    str = "\n#{env["REQUEST_METHOD"]} #{env["REQUEST_PATH"]}\n"
    str += "Headers:\n"
    str += request_headers.map { |k, v| "  #{k} = #{v}" }.join("\n") + "\n"
    b = req.body.read
    if b.empty?
      str += "Body is empty\n\n"
    else
      str += "Body:\n"
      str += "  " + b.gsub("&", "\n  ") + "\n\n"
    end
    str
  end

  def response_string
    str = "Response:\n"
    str += "  Headers:\n"
    str += res.headers.map { |k, v| "    #{k} = #{v}" }.join("\n") + "\n"
    if res.body.empty?
      str += "  Body is empty\n\n"
    else
      str += "  Body:\n"
      str += "    " + res.body.first + "\n"
    end
  end
end
