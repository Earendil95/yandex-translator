require './app'

use Rack::Session::Cookie,
  secret: ENV['SECRET'] || "secret_of_session"

run Cuba
