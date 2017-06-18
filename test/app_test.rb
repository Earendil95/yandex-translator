require_relative 'test_helper'

describe 'App' do
  let(:res) { OpenStruct.new(body: 'test', headers: {"Content-Type" => "text/html;charset=utf-8"}) }

  describe 'Check order' do
    before { TeachbaseClient.stubs(:check_order).returns(res) }

    it '200' do
      response = post '/yandex/check_order'
      response.status.must_equal 200
    end
  end

  describe 'payment_aviso' do
    before { TeachbaseClient.stubs(:payment_aviso).returns(res) }

    it '200' do
      response = post '/yandex/payment_aviso'
      response.status.must_equal 200
    end
  end
end
