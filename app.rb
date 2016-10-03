require './teachbase_client'

Cuba.plugin Cuba::Safe

Cuba.define do
  # on csrf.unsafe? do
  #   csrf.reset!

  #   res.status = 403
  #   res.write("Not authorized")

  #   halt(res.finish)
  # end

  on post do
    on "yandex" do
      on "check_order" do
        on root do
          res.write TeachbaseClient.check_order(req.params).body
        end
      end

      on "payment_aviso" do
        on root do
          res.write TeachbaseClient.payment_aviso(req.params).body
        end
      end
    end

    on true do
      res.write "404"
    end
  end

  on get do
    on root do
      res.write "Hello!"
    end
  end
end
