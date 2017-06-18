require_relative '../test_helper'

describe 'PaymentControllers' do
  let(:res) { OpenStruct.new(body: 'test', headers: {"Content-Type" => "text/html;charset=utf-8"}) }
  let(:req) { Rack::Request.new(:test) }

  describe 'Check order' do
    before { TeachbaseClient.stubs(:check_order).with(req).returns(res) }

    it '200' do
      response = post '/internal/check_order'
      response.status.must_equal 200
    end

    it '200' do
      response = post '/yandex/check_order'
      response.status.must_equal 200
    end

    it '404' do
      response = post '/internal/check_orde'
      response.status.must_equal 404
    end
  end

  describe 'payment_aviso' do
    before { TeachbaseClient.stubs(:payment_aviso).with(req).returns(res) }

    it '200' do
      response = post '/internal/payment_aviso'
      response.status.must_equal 200
    end

    it '200' do
      response = post '/yandex/payment_aviso'
      response.status.must_equal 200
    end

    it '404' do
      response = post '/internal/payment_avis'
      response.status.must_equal 404
    end
  end
end
