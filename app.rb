Cuba.plugin RRLogger
Cuba.plugin TeachbaseClient
Cuba.plugin Slacker

Cuba.define do
  on post do
    on "yandex" do
      on "check_order" do
        on root do
          begin
            response = check_order(req.params)
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
            response = payment_aviso(req.params)
            res.write response.body
            res.headers.merge! response.headers
            log_connection
            slack_post "Payment aviso"
          rescue => e
            slack_post_error e
          end
        end
      end
    end

    on true do
      res.status = 404
      res.write "404 Not Found"
      log_connection
    end
  end

  on get do
    on root do
      res.write "Hello!"
      log_connection
    end
  end
end
