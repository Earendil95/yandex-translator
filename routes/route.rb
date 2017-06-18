module YandexPaymentProxy
  class Route < Cuba
    define do
      on post do
        on "check_order" do
          on root do
            PaymentControllers.new.redirect_request(:check_order, req, res)
          end
        end

        on "payment_aviso" do
          on root do
            PaymentControllers.new.redirect_request(:payment_aviso, req, res)
          end
        end

        not_found!
      end
    end
  end
end
