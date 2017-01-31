module RRLogger
  def logger
    @logger ||= if ENV['RACK_ENV'] == 'production'
                  Logger.new File.expand_path("../", __FILE__) + '/shared/log/production.log'
                else
                  Logger.new STDOUT
                end
  end

  def log_connection
    logger.info log_string
  end

  def log_string
    "\n#{env["REQUEST_METHOD"]} #{env["REQUEST_PATH"]}\n" \
    "User id: #{req.params["customerNumber"]}\n" \
    "Product id: #{req.params["product_id"]}\n" \
    "Order id: #{req.params[orderNumber]}\n"
  end
end
