source 'https://rubygems.org'
ruby "2.3.0"
gem 'puma', '~> 2.13'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

gem 'sqlite3'

gem 'rails_12factor', group: :production

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

gem 'bootstrap-sass', '~> 3.3.5'

gem 'formtastic', '~> 2.2.1'
gem 'formtastic-bootstrap', '~> 3.0.0'

gem 'countries', '~> 0.9.3'
gem 'country_select', '~> 2.1.0'

gem 'jquery-atwho-rails'

gem 'font-awesome-sass', '~> 4.7.0'

gem "autoprefixer-rails"

gem 'activerecord-session_store'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

gem 'activemerchant', '~> 1.51.0'

gem 'active_model_serializers', '~> 0.9.3'

source 'https://rails-assets.org' do
  gem 'rails-assets-webui-popover', '~> 1.1.5'
  gem 'rails-assets-select2', '~> 4.0.0'
  gem 'rails-assets-select2-bootstrap-theme'
end

gem 'handlebars_assets'

gem 'rollbar', '~> 2.8.3'
gem 'postmark-rails', '~> 0.8.0'

gem 'gaffe', '~> 1.0.2'

# Use debugger
# gem 'debugger', group: [:development, :test]

gem 'czardom_models', path: './engines/czardom_models'
gem 'czardom_map', path: './engines/czardom_map'
gem 'czardom_messages', path: './engines/czardom_messages'
gem 'czardom_events', path: './engines/czardom_events'
gem 'czardom_admin', path: './engines/czardom_admin'

gem 'sidekiq', '~> 3.3.0'
gem 'sinatra', '>= 1.3.0', :require => nil

gem 'kaminari', '~> 0.16.3'
gem 'forem', github: "radar/forem", branch: "rails4"

gem 'flexslider', :git => 'https://github.com/constantm/Flexslider-2-Rails-Gem.git'
gem 'net-ssh'

gem 'logglier', '~> 0.3.0'
gem 'stringex'
gem 'facebook_feed'
gem 'dropzonejs-rails'
gem 'cloudinary'
gem 'acts_as_commentable_with_threading'
# auto_link replacement
gem 'rinku'

group :development do
  gem 'foreman'

  gem "binding_of_caller"
  gem "better_errors"

  # Use Capistrano for deployment
  gem 'capistrano-rails'
end

gem 'quill-rails', '~> 0.1.0'

#######################################
# TESTING
#######################################
group :test, :development do
  gem 'rspec-rails'
  gem 'jasminerice', github: 'bradphelan/jasminerice'
  gem 'pry'
  gem 'pry-remote'
  gem 'pry-rails'
  gem 'pry-byebug'
  # gem 'dotenv-rails'
  gem 'quiet_assets'
end

group :test do
  gem 'database_cleaner'
  gem 'capybara'
  gem 'cucumber-rails', require: false
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  gem 'vcr'
  gem 'webmock'
  gem 'timecop'
  gem "fakeredis", :require => "fakeredis/rspec"
  gem 'selenium-webdriver'
  gem 'launchy'
  gem 'capybara-email'
end

gem 'ckeditor_rails'

gem 'devise_lastseenable'