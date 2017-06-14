require_relative '../test_helper'

describe 'Internal routes' do
  let(:res) { OpenStruct.new(body: 'test', headers: {"Content-Type" => "text/html;charset=utf-8"}) }

  describe 'Check order' do
    before { YandexPaymentProxy::InternalRoutes.any_instance.stubs(:check_order).returns(res) }

    it '200' do
      response = post '/internal/check_order'
      response.status.must_equal 200
    end

    it '404' do
      response = post '/internal/check_orde'
      response.status.must_equal 404
    end
  end

  describe 'payment_aviso' do
    before { YandexPaymentProxy::InternalRoutes.any_instance.stubs(:payment_aviso).returns(res) }

    it '200' do
      response = post '/internal/payment_aviso'
      response.status.must_equal 200
    end

    it '404' do
      response = post '/internal/payment_avis'
      response.status.must_equal 404
    end
  end
end
