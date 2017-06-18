module YandexPaymentProxy
  class PaymentControllers < Cuba
    def redirect_request(type, req, res)
      begin
        response = public_send(type, req)
        res.write response.body
        res.headers.merge! response.headers
        log_connection req
        slack_post req, res
      rescue => e
        slack_post_error e, req
      end
    end
  end
end
