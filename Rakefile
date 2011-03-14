# Rake Hook

require 'rubygems'
#Gem::manage_gems
require 'rake/gempackagetask'

PKG_FILES = FileList[
  '[a-zA-Z]*',
  'generators/**/*',
  'lib/**/*',
  'rails/**/*',
  'tasks/**/*',
  'test/**/*'
]
 
spec = Gem::Specification.new do |s|
  s.name = "google_visualr"
  s.version = "0.0.1"
  s.author = "Winston Teo"
  s.email = "winston.yongwei+spam at gmail.com"
  s.homepage = "https://github.com/winston/google_visualr"
  s.platform = Gem::Platform::RUBY
  s.summary = "Wrapper around the Google Visualization API."
  s.files = PKG_FILES.to_a
  s.require_path = "lib"
  s.has_rdoc = false
  s.extra_rdoc_files = ["README.rdoc"]
end
 
desc 'Turn this plugin into a gem.'
Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end


---

require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rake'
require 'jeweler'

Jeweler::Tasks.new do |gem|

  gem.name        = "google_visualr"
  gem.homepage    = "http://github.com/winston/google_visualr"
  gem.license     = "MIT"
  gem.summary     = "A Ruby wrapper for the Google Visualization API."
  gem.description = "This Ruby library, GoogleVisualr, is a wrapper around the Google Visualization API and allows you to create the same visualizations with just pure Ruby; you don’t have to write any JavaScript at all."
  gem.email       = "winston.yongwei+google_visualr at gmail.com"
  gem.author      = "Winston Teo Yong Wei"

  gem.files = [
      "MIT-LICENSE",
      "README.rdoc",
      "Rakefile",
      "VERSION",
      Dir['lib/*.rb']
    ].flatten

  gem.add_development_dependency "rspec", ">= 2.5.0"

  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  
end

Jeweler::RubygemsDotOrgTasks.new

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec    => :check_dependencies
task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "google_visualr #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end