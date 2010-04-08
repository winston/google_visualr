module GoogleVisualr

  # http://code.google.com/apis/visualization/documentation/gallery/piechart.html
  class PieChart < BaseChart

    attr_accessor :element_id

    # http://code.google.com/apis/visualization/documentation/gallery/piechart.html#Configuration_Options
    attr_accessor :backgroundColor
    attr_accessor :borderColor
    attr_accessor :colors
    attr_accessor :enableTooltip
    attr_accessor :focusBorderColor
    attr_accessor :height
    attr_accessor :is3D
    attr_accessor :legend
    attr_accessor :legendBackgroundColor
    attr_accessor :legendFontSize
    attr_accessor :legendTextColor
    attr_accessor :pieJoinAngle
    attr_accessor :pieMinimalAngle
    attr_accessor :title
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