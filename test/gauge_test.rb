require File.dirname(__FILE__) + '/test_helper.rb'
require File.dirname(__FILE__) + '/../lib/gauge.rb'

class GaugeTest < Test::Unit::TestCase
	def test_gauge
		@chart = GoogleVisualr::Gauge.new
		@chart.add_column('string'  , 'Label')
		@chart.add_column('number'  , 'Value')
		@chart.add_rows(3)
		@chart.set_value(0, 0, 'Memory' )
		@chart.set_value(0, 1, 80)
		@chart.set_value(1, 0, 'CPU'    )
		@chart.set_value(1, 1, 55)
		@chart.set_value(2, 0, 'Network')
		@chart.set_value(2, 1, 68);

		options = { :width => 400, :height => 120, :redFrom => 90, :redTo => 100, :yellowFrom => 75, :yellowTo => 90, :minorTicks => 5 }
		options.each_pair do | key, value |
			@chart.send "#{key}=", value
		end

		expected = "\n<script type='text/javascript'>\n  google.load('visualization','1', {packages: ['gauge'], callback: function() {\n    var chart_data = new google.visualization.DataTable();chart_data.addColumn('string', 'Label', '');chart_data.addColumn('number', 'Value', '');chart_data.addRows(3);chart_data.setCell(0, 0, 'Memory');chart_data.setCell(0, 1, 80);chart_data.setCell(1, 0, 'CPU');chart_data.setCell(1, 1, 55);chart_data.setCell(2, 0, 'Network');chart_data.setCell(2, 1, 68);\n    var chart = new google.visualization.Gauge(document.getElementById('chart'));\n    chart.draw(chart_data, {width:400,height:120,redFrom:90,redTo:100,yellowFrom:75,yellowTo:90,minorTicks:5});\n  }});\n</script>" 
		assert_equal @chart.render('chart'), expected
	end
end	
