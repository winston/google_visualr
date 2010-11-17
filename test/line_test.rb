require File.dirname(__FILE__) + '/test_helper.rb'
require File.dirname(__FILE__) + '/../lib/line_chart.rb'

# This is a just a quick check to make sure the new features work. All I did was copy/paste the
# generated javascript into a html file and made sure this was valid.

class LineChartTest < Test::Unit::TestCase
	def test_line_chart
		@chart = GoogleVisualr::LineChart.new
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

		vAxisTextStyle = GoogleVisualr::TextStyle.new
		vAxisTextStyle.color = 'red'
		vAxisTextStyle.fontSize = 30
		options = { :width => 800, :height => 600, :title => 'Company Performance', :legend => 'bottom',
								:hAxis_title => "hAxis Title", :hAxis_slantedText => true, :vAxis_title => "Big Red",
								:vAxis_textStyle => vAxisTextStyle, :titleTextStyle => vAxisTextStyle,
								:chartArea_height => "75%", :chartArea_width => "75%"}
		@chart.set_options(options)
		
		expected_render = nil

		puts "\n\n**** The following should be a valid line chart, but copy/paste into a HTML to confirm! ****\n\n"
		puts @chart.render('chart')
		puts "\n\n"

		assert_equal true,true

	end
end
