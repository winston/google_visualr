# Bundler Gem Tasks
require 'bundler'
Bundler::GemHelper.install_tasks

# RSpec Tasks
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = ['--options', 'spec/spec.opts']
end

task :default => :spec