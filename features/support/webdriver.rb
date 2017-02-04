require 'webmock/cucumber'
WebMock.disable_net_connect!(:allow_localhost => true)

Selenium::WebDriver::Firefox::Binary.path = '/Users/baylorrae/Applications/Firefox.app/Contents/MacOS/firefox'

