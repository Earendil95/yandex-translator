module TeachbaseClient
  def tb_client(path)
    curl = Curl::Easy.new url(path)
    curl.on_header do |data|
      m = data.match /^(.*): (.*)$/
      # curl can't read response when there is this header. What about Yandex?..
      curl.headers[m[1]] = m[2].chomp unless m.nil? || m[1] == "Transfer-Encoding"
      data.length
    end
    curl
  end

  def check_order(path, params)
    current_client = tb_client(path)
    current_client.post *params.map { |k, v| "#{k}=#{v}" } do |r|
      r.headers["Content-Type"] = 'application/x-www-form-urlencoded'
    end
    current_client
  end

  def payment_aviso(path, params)
    current_client = tb_client(path)
    current_client.post *params.map { |k, v| "#{k}=#{v}" } do |r|
      r.headers["Content-Type"] = 'application/x-www-form-urlencoded'
    end
    current_client
  end

  protected
    def url(path)
      host = ENV['TEACHBASE_HOST']
      m = host.match /\/$/
      host += '/' if m.nil?
      host += path
    end
end
