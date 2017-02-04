$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "czardom_messages/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "czardom_messages"
  s.version     = CzardomMessages::VERSION
  s.authors     = ["David"]
  s.email       = ["lstar99999@gmail.com"]
  s.homepage    = "http://czardom.com"
  s.summary     = "CzardomMessages."
  s.description = "Description of CzardomMessages."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.5"

  s.add_development_dependency "combustion", "~> 0.5.3"
  s.add_development_dependency "rspec-rails", "~> 3.2.1"
  s.add_development_dependency "database_cleaner", "~> 1.4.1"
  s.add_development_dependency "factory_girl_rails", "~> 4.5.0"
  s.add_development_dependency "sqlite3", "~> 1.3.10"
  s.add_development_dependency "dotenv", "~> 2.0.2"
end
