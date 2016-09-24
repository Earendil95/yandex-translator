require 'cuba'
require 'cuba/safe'
# require 'pry-byebug'
require 'faraday'

require './app.rb'

use Rack::Session::Cookie,
  secret: ENV['SECRET'] || "secret_of_session"

run Cuba
