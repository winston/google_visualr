require 'rubygems'
require 'bundler/setup'

# Configure Rails Environment
ENV["RAILS_ENV"] = "test"
require File.expand_path("../dummy/config/environment.rb",  __FILE__)

# Load Support Files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

module JavaScriptHelper
  def normalize_javascript(input)
    dupped = input.dup

    dupped.gsub!(/\\u003E/i, ">")
    dupped.gsub!(/\\u003C/i, "<")

    dupped
  end
end

RSpec.configure do |config|
  # some (optional) config here
  include JavaScriptHelper
end
