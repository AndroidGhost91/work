VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock

  c.filter_sensitive_data('<PAYPAL_API_USERNAME>') { ENV.fetch('PAYPAL_API_USERNAME') }
  c.filter_sensitive_data('<PAYPAL_API_PASSWORD>') { ENV.fetch('PAYPAL_API_PASSWORD') }
  c.filter_sensitive_data('<PAYPAL_API_SIGNATURE>') { ENV.fetch('PAYPAL_API_SIGNATURE') }
end
