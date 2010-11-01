module GoogleVisualr

  # http://code.google.com/apis/visualization/documentation/gallery/barchart.html
  class BarChart < BaseChart

    attr_accessor :element_id

    # http://code.google.com/apis/visualization/documentation/gallery/barchart.html#Configuration_Options
    attr_accessor :backgroundColor
    attr_accessor :colors
   	attr_accessor :fontSize
   	attr_accessor :fontName
   	attr_accessor :hAxisBaseline
		attr_accessor :hAxisBaselineColor
		attr_accessor :hAxisDirection
		attr_accessor :hAxisLogScale
		attr_accessor :hAxisTextStyle
		attr_accessor :hAxisTitle
		attr_accessor :hAxisTitleTextStyle
		attr_accessor :hAxisMaxValue
		attr_accessor :hAxisMinValue
		attr_accessor :height
    attr_accessor :isStacked
    attr_accessor :legend
    attr_accessor :legendTextStyle
    attr_accessor :reverseCategories
    attr_accessor :title
    attr_accessor :titleTextStyle
    attr_accessor :tooltip
    attr_accessor :tooltipTextStyle
    attr_accessor :vAxisDirection
    attr_accessor :vAxisTextStyle
    attr_accessor :vAxisTitle
    attr_accessor :vAxisTitleTextStyle
    attr_accessor :width

    def render (element_id)

      options = Hash.new

      options[:package]     = self.class.to_s.split('::').last
      options[:element_id]  = element_id
      options[:chart_style] = collect_parameters

      super(options)

    end

  end

end
