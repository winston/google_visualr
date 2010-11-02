require 'test/unit'
require File.dirname(__FILE__) + '/test_helper.rb'
require File.dirname(__FILE__) + '/../lib/base_chart.rb'
require File.dirname(__FILE__) + '/../lib/annotated_time_line.rb'

class AnnotatedTimelineTest < Test::Unit::TestCase
	def test_annotated_timeline
		@chart = GoogleVisualr::AnnotatedTimeLine.new
		@chart.add_column('date'  , 'Date')
		@chart.add_column('number', 'Sold Pencils')
		@chart.add_column('string', 'title1')
		@chart.add_column('string', 'text1' )
		@chart.add_column('number', 'Sold Pens'   )
		@chart.add_column('string', 'title2')
		@chart.add_column('string', 'text2' )
		@chart.add_rows( [
			[ Date.parse("2008-2-1"), 30000, '', '', 40645, '', ''],
			[ Date.parse("2008-2-2"), 14045, '', '', 20374, '', ''],
			[ Date.parse("2008-2-3"), 55022, '', '', 50766, '', ''],
			[ Date.parse("2008-2-4"), 75284, '', '', 14334, 'Out of Stock','Ran out of stock on pens at 4pm'],
			[ Date.parse("2008-2-5"), 41476, 'Bought Pens','Bought 200k pens', 66467, '', ''],
			[ Date.parse("2008-2-6"), 33322, '', '', 39463, '', '']
		] )

		options = { :displayAnnotations => true }
		options.each_pair do | key, value |
			@chart.send "#{key}=", value
		end
		
		expected_render = "\n<script type='text/javascript'>\n  google.load('visualization','1', {packages: ['annotatedtimeline'], callback: function() {\n    var chart_data = new google.visualization.DataTable();chart_data.addColumn('date', 'Date', '');chart_data.addColumn('number', 'Sold Pencils', '');chart_data.addColumn('string', 'title1', '');chart_data.addColumn('string', 'text1', '');chart_data.addColumn('number', 'Sold Pens', '');chart_data.addColumn('string', 'title2', '');chart_data.addColumn('string', 'text2', '');chart_data.addRow( [new Date(2008, 1, 1),30000,'','',40645,'',''] );chart_data.addRow( [new Date(2008, 1, 2),14045,'','',20374,'',''] );chart_data.addRow( [new Date(2008, 1, 3),55022,'','',50766,'',''] );chart_data.addRow( [new Date(2008, 1, 4),75284,'','',14334,'Out of Stock','Ran out of stock on pens at 4pm'] );chart_data.addRow( [new Date(2008, 1, 5),41476,'Bought Pens','Bought 200k pens',66467,'',''] );chart_data.addRow( [new Date(2008, 1, 6),33322,'','',39463,'',''] );\n    var chart = new google.visualization.AnnotatedTimeLine(document.getElementById('chart'));\n    chart.draw(chart_data, {displayAnnotations:true});\n  }});\n</script>"

		assert_equal @chart.render('chart'), expected_render, "There was a discrepency between the actual and expected render" 
	end
end
