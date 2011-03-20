# -*- encoding: utf-8 -*-
require File.expand_path("../lib/gv/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "google_visualr"
  s.version     = Gv::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Winston Teo"]
  s.email       = ["winston.yongwei+google_visualr@gmail.com"]
  s.homepage    = "https://github.com/winston/google_visualr"
  s.summary     = "Ruby wrapper around the Google Visualization API."
  s.description = "This Ruby library, GoogleVisualr, is a wrapper around the Google Visualization API and allows you to create the same visualizations with just pure Ruby; you don’t have to write any JavaScript at all."
  s.extra_rdoc_files = ["README.rdoc"]

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "google_visualr"

  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "rspec"  , ">= 2.5.0"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
