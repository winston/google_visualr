require File.dirname(__FILE__) + '/../lib/base_chart.rb'
require File.dirname(__FILE__) + '/../lib/bar_chart.rb'
require 'test/unit'
class BarChartTest < Test::Unit::TestCase	
	def test_bar_chart
		@chart = GoogleVisualr::BarChart.new
		@chart.add_column('string', 'Year')
		@chart.add_column('number', 'Sales')
		@chart.add_column('number', 'Expenses')
		@chart.add_rows(4)
		@chart.set_value(0, 0, '2004')
		@chart.set_value(0, 1, 1000)
		@chart.set_value(0, 2, 400)
		@chart.set_value(1, 0, '2005')
		@chart.set_value(1, 1, 1170)
		@chart.set_value(1, 2, 460)
		@chart.set_value(2, 0, '2006')
		@chart.set_value(2, 1, 1500)
		@chart.set_value(2, 2, 660)
		@chart.set_value(3, 0, '2007')
		@chart.set_value(3, 1, 1030)
		@chart.set_value(3, 2, 540)

		options = { :width => 400, :height => 240, :title => 'Company Performance'}
		options.each_pair do | key, value |
			@chart.send "#{key}=", value
		end
	
		puts @chart.render('chart')

		expected_render = "\n<script type='text/javascript'>
  google.load('visualization','1', {packages: ['barchart'], callback: function() {
    var chart_data = new google.visualization.DataTable();chart_data.addColumn('string', 'Year', '');chart_data.addColumn('number', 'Sales', '');chart_data.addColumn('number', 'Expenses', '');chart_data.addRows(4);chart_data.setCell(0, 0, '2004');chart_data.setCell(0, 1, 1000);chart_data.setCell(0, 2, 400);chart_data.setCell(1, 0, '2005');chart_data.setCell(1, 1, 1170);chart_data.setCell(1, 2, 460);chart_data.setCell(2, 0, '2006');chart_data.setCell(2, 1, 1500);chart_data.setCell(2, 2, 660);chart_data.setCell(3, 0, '2007');chart_data.setCell(3, 1, 1030);chart_data.setCell(3, 2, 540);
    var chart = new google.visualization.BarChart(document.getElementById('chart'));
    chart.draw(chart_data, {width:400,height:240,title:'Company Performance'});
  }});
</script>"
	
		assert_equal @chart.render('chart'), expected_render
	end
end
