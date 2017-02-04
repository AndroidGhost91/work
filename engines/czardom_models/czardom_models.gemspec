$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "czardom_models/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "czardom_models"
  s.version     = CzardomModels::VERSION
  s.authors     = ["Baylor Rae'"]
  s.email       = ["baylor@thecodedeli.com"]
  s.homepage    = "http://czardom.com"
  s.summary     = "Models for the CZARDOM app"
  s.description = "Models for the CZARDOM app"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.5"

  s.add_dependency "cancancan", "~> 1.9.2"
  s.add_dependency "algoliasearch-rails", "~> 1.13.0"
  s.add_dependency "friendly_id", "~> 5.0.4"
  s.add_dependency "mailboxer"

  s.add_dependency "ancestry", "~> 2.1.0"

  s.add_dependency 'devise'
  s.add_dependency 'omniauth-facebook', '~> 3.0.0'
  s.add_dependency 'koala', '~> 2.2.0'

  s.add_dependency 'rmagick', '~> 2.15.3'
  s.add_dependency 'carrierwave', '0.10.0'
  s.add_dependency 'fog', '~> 1.28.0'
  s.add_dependency 'fog-aws', '~> 0.1.1'
  s.add_dependency 'geocoder', '~> 1.2.5'
  s.add_dependency 'state_machine', '~> 1.2.0'
  s.add_dependency 'draper', '~> 2.1.0'
  s.add_dependency 'aasm', '~> 4.1.1'
  s.add_dependency 'recommendable', '~> 2.2.0'

  s.add_dependency 'role_model', '~> 0.8.2'

  s.add_dependency 'payola-payments', '~> 1.3.2'

  s.add_dependency 'knockoutjs-rails', '~> 3.3.0'

  s.add_development_dependency "pg"
  s.add_development_dependency "combustion", "~> 0.5.3"
  s.add_development_dependency "rspec-rails", "~> 3.2.1"
  s.add_development_dependency "database_cleaner", "~> 1.4.1"
  s.add_development_dependency "factory_girl_rails", "~> 4.5.0"
  s.add_development_dependency "sqlite3", "~> 1.3.10"
  s.add_development_dependency "dotenv", "~> 2.0.2"
end
