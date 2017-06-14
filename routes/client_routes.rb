module YandexPaymentProxy
  class ClientRoutes < Cuba
    define do
      on post do
        on "check_order" do
          on root do
            begin
              response = check_order("yandex/check_order", req.params)
              res.write response.body
              res.headers.merge! response.headers
              log_connection
              slack_post "Check order"
            rescue => e
              slack_post_error e
            end
          end
        end

        on "payment_aviso" do
          on root do
            begin
              response = payment_aviso("yandex/payment_aviso", req.params)
              res.write response.body
              res.headers.merge! response.headers
              log_connection
              slack_post "Payment aviso"
            rescue => e
              slack_post_error e
            end
          end
        end

        not_found!
      end
    end
  end
end
