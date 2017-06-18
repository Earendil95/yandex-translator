require 'cuba'
require 'logger'
require 'curb'
require 'json'
require './lib/rrlogger'
require './lib/slacker'
require './lib/teachbase_client'
require './helpers/routes'

Cuba.plugin TeachbaseClient
Cuba.plugin RRLogger
Cuba.plugin Slacker
Cuba.plugin YandexPaymentProxy::Helpers

Cuba.define do
  on post do
    begin
      response = forward_request_to_tb
      res.write response.body
      res.headers.merge! response.headers
      log_connection
      slack_post
    rescue => e
      slack_post_error e
    end
  end

  not_found!

  on get do
    on root do
      res.write "Hello!"
      log_connection
    end
  end
end
