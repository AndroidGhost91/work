paypal_options = {
  :login => ENV.fetch('PAYPAL_API_USERNAME'),
  :password => ENV.fetch('PAYPAL_API_PASSWORD'),
  :signature => ENV.fetch('PAYPAL_API_SIGNATURE')
}
EXPRESS_GATEWAY = ActiveMerchant::Billing::PaypalExpressGateway.new(paypal_options)
