Cuba.plugin RRLogger
Cuba.plugin TeachbaseClient

Cuba.define do
  on post do
    on "yandex" do
      on "check_order" do
        on root do
          response = check_order(req.params)
          res.headers.merge! response.env.response_headers
          res.write response.body
          log_connection
        end
      end

      on "payment_aviso" do
        on root do
          response = payment_aviso(req.params).body
          res.headers.merge! response.env.response_headers
          res.write response.body
          log_connection
        end
      end
    end

    on true do
      res.status 404
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
