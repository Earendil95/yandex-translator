module YandexPaymentProxy
  module Helpers
    def not_found!
      res.status = 404
      res.write '404 Not Found'
      log_connection req
    end
  end
end
