module TeachbaseClient
  def tb_client(path)
    curl = Curl::Easy.new url(path)
    curl.on_header do |data|
      m = data.match %r{/^(.*): (.*)$/}
      # curl can't read response when there is this header. What about Yandex?..
      curl.headers[m[1]] = m[2].chomp unless m.nil? || m[1] == 'Transfer-Encoding'
      data.length
    end
    curl.ssl_verify_peer = false
    curl
  end

  def url(path)
    host = ENV['TEACHBASE_HOST'].gsub(/\/$/,'')
    host += path
  end

  def forward_request_to_tb
    current_client = tb_client(req.path)
    current_client.post req.params.map { |k, v| "#{k}=#{v}" } do |r|
      r.headers['Content-Type'] = 'application/x-www-form-urlencoded'
    end
    current_client
  end
end
