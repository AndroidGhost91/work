Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true
  # config.action_mailer.default_url_options = { :host => 'https://czardom-liuming3.c9users.io/' }
  # config.action_mailer.delivery_method = :postmark
  # config.action_mailer.postmark_settings = { :api_key => '0522fbcf-d60c-46f1-9efc-cd53fe246798' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = { :address => "localhost", :port => 1025 }
  config.action_mailer.default_url_options = { :host => 'http://localhost:3000' }
    
  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # config.after_initialize do
  #   ActiveMerchant::Billing::Base.mode = :test
  #   paypal_options = {
  #     :login => ENV.fetch('PAYPAL_API_USERNAME'),
  #     :password => ENV.fetch('PAYPAL_API_PASSWORD'),
  #     :signature => ENV.fetch('PAYPAL_API_SIGNATURE')
  #   }
  #   ::EXPRESS_GATEWAY = ActiveMerchant::Billing::PaypalExpressGateway.new(paypal_options)
  # end
end

Rails.application.routes.default_url_options[:host] = 'localhost:3000'
CzardomEvents::Engine.routes.default_url_options[:host] = 'localhost:3000'
Forem::Engine.routes.default_url_options[:host] = 'localhost:3000'
# # # # # # # # # 