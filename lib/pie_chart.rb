module GoogleVisualr

  # http://code.google.com/apis/visualization/documentation/gallery/piechart.html
  class PieChart < BaseChart

    attr_accessor :element_id

    # http://code.google.com/apis/visualization/documentation/gallery/piechart.html#Configuration_Options
    attr_accessor :backgroundColor
    attr_accessor :backgroundColor_stroke
    attr_accessor :backgroundColor_strokeWidth
    attr_accessor :backgroundColor_fill
    attr_accessor :chartArea_left
    attr_accessor :chartArea_top
    attr_accessor :chartArea_width
    attr_accessor :chartArea_height
    attr_accessor :colors
    attr_accessor :fontSize
    attr_accessor :fontName
    attr_accessor :height
    attr_accessor :is3D
    attr_accessor :legend
    attr_accessor :legendTextStyle
    attr_accessor :pieSliceText
    attr_accessor :pieSliceTextStyle
    attr_accessor :reverseCategory
    attr_accessor :sliceVisibilityThreshold
    attr_accessor :pieResidueSliceLabel
    attr_accessor :title
    attr_accessor :titleTextStyle
    attr_accessor :tooltipTextStyle
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
