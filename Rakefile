# ser23
require 'rake'
require 'test/unit'

require File.dirname(__FILE__) + '/lib/base_chart'
require File.dirname(__FILE__) + '/lib/bar_chart'


task :default
class BarChartTest < Test::Unit::TestCase
	
	def new_bar_chart
		@chart = GoogleVisualr::BarChart.new
		assert(@chart, 'The chart was not successfully created!')
	end
end
