require 'test/unit'
require File.dirname(__FILE__) + '/test_helper.rb'
require File.dirname(__FILE__) + '/../lib/text_style.rb'
require File.dirname(__FILE__) + '/../lib/base_chart.rb'

class BaseChartTest < Test::Unit::TestCase
	def test_full_text_style
		@style = GoogleVisualr::TextStyle.new
		@style.color = 'black'
		@style.fontName = 'Helvetica'
		@style.fontSize = 14
		expected = "{color: 'black', fontName: 'Helvetica', fontSize: 14}"
		assert_equal @style.to_s, expected
	end
end
