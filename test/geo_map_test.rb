require File.dirname(__FILE__) + '/test_helper.rb'
require File.dirname(__FILE__) + '/../lib/geo_map.rb'

class GeoMapTest < Test::Unit::TestCase
	def test_geo_map
		@chart_regions = GoogleVisualr::GeoMap.new
		@chart_regions.add_column('string'  , 'Country'   )
		@chart_regions.add_column('number'  , 'Popularity')
		@chart_regions.add_rows(6)
		@chart_regions.set_value(0, 0, 'Germany'      );
		@chart_regions.set_value(0, 1, 200);
		@chart_regions.set_value(1, 0, 'United States');
		@chart_regions.set_value(1, 1, 300);
		@chart_regions.set_value(2, 0, 'Brazil'       );
		@chart_regions.set_value(2, 1, 400);
		@chart_regions.set_value(3, 0, 'Canada'       );
		@chart_regions.set_value(3, 1, 500);
		@chart_regions.set_value(4, 0, 'France'       );
		@chart_regions.set_value(4, 1, 600);
		@chart_regions.set_value(5, 0, 'RU'           );
		@chart_regions.set_value(5, 1, 700);

		options = { :dataMode => 'regions' }
		options.each_pair do | key, value |
			@chart_regions.send "#{key}=", value
		end

		expected = "\n<script type='text/javascript'>\n  google.load('visualization','1', {packages: ['geomap'], callback: function() {\n    var chart_data = new google.visualization.DataTable();chart_data.addColumn('string', 'Country', '');chart_data.addColumn('number', 'Popularity', '');chart_data.addRows(6);chart_data.setCell(0, 0, 'Germany');chart_data.setCell(0, 1, 200);chart_data.setCell(1, 0, 'United States');chart_data.setCell(1, 1, 300);chart_data.setCell(2, 0, 'Brazil');chart_data.setCell(2, 1, 400);chart_data.setCell(3, 0, 'Canada');chart_data.setCell(3, 1, 500);chart_data.setCell(4, 0, 'France');chart_data.setCell(4, 1, 600);chart_data.setCell(5, 0, 'RU');chart_data.setCell(5, 1, 700);\n    var chart = new google.visualization.GeoMap(document.getElementById('chart'));\n    chart.draw(chart_data, {dataMode:'regions'});\n  }});\n</script>"
		
		assert_equal @chart_regions.render('chart'), expected
	end
end
