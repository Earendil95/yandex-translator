module Slacker
  def webhook
    @webhook ||= (ENV['SLACK_WEBHOOK'] || 'https://hooks.slack.com/services/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')
  end

  def slack_client
    Curl::Easy.new webhook
  end

  def slack_post(text)
    params = perform_message(text)
    slack_client.post params
  end

  def slack_post_error(error)
    params = perform_error_message(error)
    slack_client.post params
  end

  def perform_message(head)
    str = "*#{head}*; order number _#{req.params["orderNumber"]}_\n"
    str += "*User ID*: #{req.params["customerNumber"]}\n"
    str += "*User fullname*: #{req.params["user_fullname"]}\n"
    str += "*Product ID*: #{req.params["product_id"]}\n"
    str += "*Product name*: #{req.params["product_name"]}\n"
    m = res.body.first.match /code="(\d{1,3})"/
    if m.nil?
      str += "*_WTF?!?!?!_*"
    else
      str += case m[1]
             when "0"
               "Success"
             when "1"
               "Authorization failed"
             when "200"
               "Order not found"
             end
    end
    { text: str }.to_json
  end

  def perform_error_message(e)
    {
      text: "*#{e.class}*: #{e.message}\n" \
            "backtrace:\n" \
            "```#{e.backtrace.join "\n"}```\n" \
            "on `POST yandex/payment_aviso`\n" \
            "with headers:\n```#{request_headers.map { |k, v| "#{k} = #{v}" }.join "\n"}```\n" \
            "with params:\n```#{req.params.map { |k, v| "#{k} = #{v}" }.join("\n")}```"
    }.to_json
  end
end
