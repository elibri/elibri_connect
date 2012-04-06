$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "elibri_connect/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "elibri_connect"
  s.version     = ElibriConnect::VERSION
  s.authors     = ["Piotr Szmielew"]
  s.email       = ["p.szmielew@ava.waw.pl"]
  s.homepage    = "http://elibri.com.pl"
  s.summary     = "Gem designed to allow easy addition of elibri based product system to your application."
  s.description = "Gem designed to allow easy addition of elibri based product system to your application.
  Currently tested and support only on REE - due to dependencies."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.0"
  s.add_dependency "acts_as_elibri_product"
  s.add_dependency "elibri_api_client"
  s.add_dependency "elibri_onix_mocks"
  s.add_dependency "whenever"

  s.add_development_dependency "sqlite3"

  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-rails"
end
