module GoogleVisualr
  module Visualizations

    # http://code.google.com/apis/visualization/documentation/gallery/areachart.html
    class AreaChart < BaseChart
      include GoogleVisualr::Packages::CoreChart  

      attr_accessor :element_id

      # http://code.google.com/apis/visualization/documentation/gallery/areachart.html#Configuration_Options
      attr_accessor :axisTitlesPosition
      attr_accessor :backgroundColor
      attr_accessor :backgroundColor_stroke
      attr_accessor :backgroundColor_strokeWidth
      attr_accessor :backgroundColor_fill
      attr_accessor :chartArea
      attr_accessor :chartArea_left
      attr_accessor :chartArea_top
      attr_accessor :chartArea_width
      attr_accessor :chartArea_height
      attr_accessor :colors
      attr_accessor :fontSize
      attr_accessor :fontName
      attr_accessor :gridlineColor
      attr_accessor :hAxis
      attr_accessor :hAxis_direction
      attr_accessor :hAxis_textPosition
      attr_accessor :hAxis_textStyle
      attr_accessor :hAxis_title
      attr_accessor :hAxis_titleTextStyle
      attr_accessor :hAxis_slantedText
      attr_accessor :hAxis_slantedTextAngle
      attr_accessor :hAxis_maxAlternation
      attr_accessor :hAxis_showTextEvery
      attr_accessor :height
      attr_accessor :isStacked
      attr_accessor :legend
      attr_accessor :legendTextStyle
      attr_accessor :lineWidth
      attr_accessor :pointSize
      attr_accessor :reverseCategories
      attr_accessor :title
      attr_accessor :titlePosition
      attr_accessor :titleTextStyle
      attr_accessor :tooltipTextStyle
      attr_accessor :vAxis
      attr_accessor :vAxis_baseline
      attr_accessor :vAxis_baselineColor
      attr_accessor :vAxis_direction
      attr_accessor :vAxis_format
      attr_accessor :vAxis_logScale
      attr_accessor :vAxis_textPosition
      attr_accessor :vAxis_textStyle
      attr_accessor :vAxis_title
      attr_accessor :vAxis_titleTextStyle
      attr_accessor :vAxis_maxValue
      attr_accessor :vAxis_minValue
      attr_accessor :width
    end

  end
end