$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "google_visualr/version"

Gem::Specification.new do |s|
  s.name        = "google_visualr"
  s.version     = GoogleVisualr::VERSION
  s.authors     = ["Winston Teo"]
  s.email       = ["winston.yongwei+google_visualr@gmail.com"]
  s.homepage    = "https://github.com/winston/google_visualr"
  s.summary     = "A Ruby wrapper around the Google Chart Tools that allows anyone to create the same beautiful charts with just plain Ruby."
  s.description = "This Ruby gem, GoogleVisualr, is a wrapper around the Google Chart Tools that allows anyone to create the same beautiful charts with just Ruby; you don't have to write any JavaScript at all."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.markdown"]
  s.test_files = Dir["spec/**/*"]

  s.add_development_dependency "bundler", ">= 1.3.5"
  s.add_development_dependency "rspec"  , ">= 2.14.1"
  s.add_development_dependency "rails"  , ">= 3.2"

  s.license = 'MIT'
end
