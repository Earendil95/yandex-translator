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

  def check_order(params)
    current_client = tb_client("yandex/check_order")
    current_client.post *params.map { |k, v| "#{k}=#{v}" } do |r|
      r.headers["Content-Type"] = 'application/x-www-form-urlencoded'
    end
    current_client
  end

  def payment_aviso(params)
    current_client = tb_client("yandex/payment_aviso")
    current_client.post *params.map { |k, v| "#{k}=#{v}" } do |r|
      r.headers["Content-Type"] = 'application/x-www-form-urlencoded'
    end
    current_client
  end

  def url(path)
    host = ENV['TEACHBASE_HOST']
    m = host.match /\/$/
    host += '/' if m.nil?
    host += path
  end
end
