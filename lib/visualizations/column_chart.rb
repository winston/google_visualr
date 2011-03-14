module GoogleVisualr

  # http://code.google.com/apis/visualization/documentation/gallery/columnchart.html
  class ColumnChart < BaseChart

    attr_accessor :element_id

    # http://code.google.com/apis/visualization/documentation/gallery/columnchart.html#Configuration_Options
    attr_accessor :axisColor
    attr_accessor :axisBackgroundColor
    attr_accessor :axisFontSize
    attr_accessor :backgroundColor
    attr_accessor :borderColor
    attr_accessor :colors
    attr_accessor :enableTooltip
    attr_accessor :focusBorderColor
    attr_accessor :height
    attr_accessor :is3D
    attr_accessor :isStacked
    attr_accessor :legend
    attr_accessor :legendBackgroundColor
    attr_accessor :legendFontSize
    attr_accessor :legendTextColor
    attr_accessor :logScale
    attr_accessor :max
    attr_accessor :min
    attr_accessor :reverseAxis
    attr_accessor :showCategories
    attr_accessor :title
    attr_accessor :titleX
    attr_accessor :titleY
    attr_accessor :titleColor
    attr_accessor :titleFontSize
    attr_accessor :tooltipFontSize
    attr_accessor :tooltipHeight
    attr_accessor :tooltipWidth
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