class TeachbaseClient
  class << self
    def check_order(params)
      new(params).check_order
    end

    def payment_aviso(params)
      new(params).payment_aviso
    end
  end

  attr_reader :connect, :request_params

  def initialize(params)
    @request_params = params
    @connect = Faraday.new url: ENV['TEACHBASE_HOST'] || 'http://213.134.198.189:3002/'
  end

  def check_order
    response = connect.post "yandex/check_order" do |r|
      r.body = request_params
      r.headers["Content-Type"] = 'application/x-www-form-urlencoded'
    end
  end

  def payment_aviso
    response = connect.post "yandex/payment_aviso" do |r|
      r.body = request_params
      r.headers["Content-Type"] = 'application/x-www-form-urlencoded'
    end
  end
end
