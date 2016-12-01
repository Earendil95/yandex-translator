require 'cuba'
require 'logger'
require 'curb'
require 'json'

require './rrlogger'
require './teachbase_client'
require './slacker'
require './app'

use Rack::Session::Cookie,
  secret: ENV['SECRET'] || "secret_of_session"

run Cuba
