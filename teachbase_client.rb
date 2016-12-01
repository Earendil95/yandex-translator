module TeachbaseClient
  def tb_client
    Faraday.new url: ENV['TEACHBASE_HOST']
  end

  def check_order(params)
    response = tb_client.post "yandex/check_order" do |r|
      r.body = params
      r.headers["Content-Type"] = 'application/x-www-form-urlencoded'
    end
  end

  def payment_aviso(params)
    response = tb_client.post "yandex/payment_aviso" do |r|
      r.body = params
      r.headers["Content-Type"] = 'application/x-www-form-urlencoded'
    end
  end
end
