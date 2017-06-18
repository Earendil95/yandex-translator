require 'cuba'
require 'logger'
require 'curb'
require 'json'
require './lib/rrlogger'
require './lib/slacker'
require './lib/teachbase_client'
require './routes/route'
require './controllers/payment_controllers'
require './helpers/routes'

Cuba.plugin TeachbaseClient
Cuba.plugin RRLogger
Cuba.plugin Slacker
Cuba.plugin YandexPaymentProxy::Helpers

Cuba.define do
  on "yandex" do
    run YandexPaymentProxy::Route
  end

  on "internal" do
    run YandexPaymentProxy::Route
  end

  not_found!

  on get do
    on root do
      res.write "Hello!"
      log_connection req
    end
  end
end
