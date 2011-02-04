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
