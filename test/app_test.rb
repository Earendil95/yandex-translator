require_relative 'test_helper'

describe Cuba do
  let(:res) do
    OpenStruct.new(body: 'test', headers: { 'Content-Type' => 'text/html' })
  end

  before(:all) do
    TeachbaseClient.stubs(:forward_request_to_tb).returns(res)
    sleep(0.5)
  end

  describe 'yandex' do
    it 'check order 200' do
      response = post '/yandex/check_order'
      response.status.must_equal 200
    end

    it 'payment_aviso 200' do
      response = post '/yandex/payment_aviso'
      response.status.must_equal 200
    end

    it 'check_ord 404' do
      response = post '/yandex/check_ord'
      response.status.must_equal 404
    end

    it 'root 404' do
      response = post '/yandex'
      response.status.must_equal 404
    end
  end

  describe 'payments' do
    it 'check_order 200' do
      response = post '/payments/check_order'
      response.status.must_equal 200
    end

    it 'payment_aviso 200' do
      response = post '/payments/payment_aviso'
      response.status.must_equal 200
    end

    it 'payment_av 404' do
      response = post '/payments/payment_av'
      response.status.must_equal 404
    end

    it 'root 404' do
      response = post '/payments/'
      response.status.must_equal 404
    end
  end

  describe 'blabla' do
    it 'payment_aviso 404' do
      response = post '/blabla/payment_aviso'
      response.status.must_equal 404
    end

    it 'root 404' do
      response = post '/blabla'
      response.status.must_equal 404
    end
  end

  describe 'root' do
    it '404' do
      response = post '/'
      response.status.must_equal 404
    end
  end
end
