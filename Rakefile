# ser23
require 'rake/testtask'

def scope(path)
	File.join(File.dirname(__FILE__), path)
end

require scope('/lib/base_chart')


# --- Default: Testing ---
task :default => :test

desc "Run the GoogleVisualr Test Suite"
task :test do

	Rake::TestTask.new do |t|
		test_files = FileList[scope('test/**/*_test.rb')]
		t.test_files = test_files
		t.verbose = true
	end
end
