require 'cuba'
require 'logger'
require 'faraday'

require './rrlogger'
require './teachbase_client'
require './app.rb'

use Rack::Session::Cookie,
  secret: ENV['SECRET'] || "secret_of_session"

run Cuba
