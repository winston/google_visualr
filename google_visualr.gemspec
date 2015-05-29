# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "google_visualr/version"

Gem::Specification.new do |spec|
  spec.name        = "google_visualr"
  spec.version     = GoogleVisualr::VERSION
  spec.authors     = ["Winston Teo"]
  spec.email       = ["winston.yongwei+google_visualr@gmail.com"]
  spec.homepage    = "https://github.com/winston/google_visualr"
  spec.summary     = "A Ruby wrapper around the Google Chart Tools that allows anyone to create the same beautiful charts with just plain Ruby."
  spec.description = "This Ruby gem, GoogleVisualr, is a wrapper around the Google Chart Tools that allows anyone to create the same beautiful charts with just Ruby; you don't have to write any JavaScript at all."
  spec.files       = `git ls-files -z`.split("\x0")
  spec.license     = 'MIT'

  spec.required_ruby_version = '>= 2.0.0'
end
