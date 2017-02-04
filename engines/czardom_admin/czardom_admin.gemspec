$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "czardom_admin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "czardom_admin"
  s.version     = CzardomAdmin::VERSION
  s.authors     = ["Baylor Rae'"]
  s.email       = ["baylor@thecodedeli.com"]
  s.homepage    = "http://czardom.com/admin"
  s.summary     = "Handles admin page"
  s.description = "Handles admin page"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.5"
  s.add_dependency "mailboxer"
 
end
