require 'test/unit'
require File.dirname(__FILE__) + '/../lib/helpers.rb'
require File.dirname(__FILE__) + '/../lib/base_chart.rb'

class Object
	# This is part of Rails, but adding here so that tests can be run without loading the whole rails env
	def instance_variable_names
		instance_variables.map { |var| var.to_s }
	end
end
