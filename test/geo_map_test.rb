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
		
		assert_equal @chart_regions('chart'), nil
