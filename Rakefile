# Bundler Gem Tasks
require 'bundler'
Bundler::GemHelper.install_tasks

# RSpec Tasks
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = ['--options', '.rspec']
end

task :default => :spec