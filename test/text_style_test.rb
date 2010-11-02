require File.dirname(__FILE__) + '/test_helper.rb'
require File.dirname(__FILE__) + '/../lib/text_style.rb'

class BaseChartTest < Test::Unit::TestCase
	def test_full_text_style
		@style = GoogleVisualr::TextStyle.new
		@style.color = 'black'
		@style.fontName = 'Helvetica'
		@style.fontSize = 14
		expected = "{color: 'black', fontName: 'Helvetica', fontSize: 14}"
		assert_equal @style.to_s, expected
	end

	def test_almost_full_text_style
		@style = GoogleVisualr::TextStyle.new
		@style.color = 'black'
		expected = "{color: 'black'}"
		assert_equal @style.to_s, expected
	end

	def test_empty_text_style
		@style = GoogleVisualr::TextStyle.new
		expected = "{}"
		assert_equal @style.to_s, expected
	end
end
