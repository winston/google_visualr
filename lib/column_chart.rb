module GoogleVisualr

  # http://code.google.com/apis/visualization/documentation/gallery/columnchart.html
  class ColumnChart < BaseChart

    attr_accessor :element_id

    # http://code.google.com/apis/visualization/documentation/gallery/columnchart.html#Configuration_Options
    attr_accessor :backgroundColor
    attr_accessor :colors
    attr_accessor :enableTooltip
    attr_accessor :focusBorderColor
    attr_accessor :fontSize
    attr_accessor :fontName
    attr_accessor :hAxisDirection
    attr_accessor :hAxisTextStyle
    attr_accessor :hAxisSlantedText
    attr_accessor :hAxisSlantedTextAngle
    attr_accessor :hAxisMaxAlternation
    attr_accessor :hAxisShowTextEvery
    attr_accessor :height
    attr_accessor :isStacked
    attr_accessor :legend
    attr_accessor :legendTextStyle
    attr_accessor :reverseCategories
    attr_accessor :showCategories
    attr_accessor :title
    attr_accessor :titleTextStyle
    attr_accessor :tooltipTextStyle
    attr_accessor :vAxisBaseline
    attr_accessor :vAxisBaselineColor
    attr_accessor :vAxisDirection
    attr_accessor :vAxisLogScale
    attr_accessor :vAxisTextStyle
    attr_accessor :vAxisTitle
    attr_accessor :vAxisTitleTextStyle
    attr_accessor :vAxisMaxValue
    attr_accessor :vAxisMinValue
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
