$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "czardom_map/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "czardom_map"
  s.version     = CzardomMap::VERSION
  s.authors     = ["David"]
  s.email       = ["lstar99999@gmail.com"]
  s.homepage    = "http://czardom.com"
  s.summary     = "TCzardomMap."
  s.description = "Description of CzardomMap."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.5"
end
