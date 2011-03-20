module GoogleVisualr
  module Visualizations

    # http://code.google.com/apis/visualization/documentation/gallery/areachart.html
    class AreaChart < BaseChart
      include GoogleVisualr::Packages::CoreChart

      attr_accessor :element_id

      # http://code.google.com/apis/visualization/documentation/gallery/areachart.html#Configuration_Options
      attr_accessor :axisTitlesPosition
      attr_accessor :backgroundColor
#      attr_accessor :"backgroundColor.stroke"
#      attr_accessor :"backgroundColor.strokeWidth"
#      attr_accessor :"backgroundColor.fill"
      attr_accessor :chartArea
#      attr_accessor :"chartArea.left"
#      attr_accessor :"chartArea.top"
#      attr_accessor :"chartArea.width"
#      attr_accessor :"chartArea.height"
      attr_accessor :colors
      attr_accessor :fontSize
      attr_accessor :fontName
      attr_accessor :gridlineColor
      attr_accessor :hAxis
#      attr_accessor :"hAxis.direction"
#      attr_accessor :"hAxis.textPosition"
#      attr_accessor :"hAxis.textStyle"
#      attr_accessor :"hAxis.title"
#      attr_accessor :"hAxis.titleTextStyle"
#      attr_accessor :"hAxis.slantedText"
#      attr_accessor :"hAxis.slantedTextAngle"
#      attr_accessor :"hAxis.maxAlternation"
#      attr_accessor :"hAxis.showTextEvery"
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
#      attr_accessor :"vAxis.baseline"
#      attr_accessor :"vAxis.baselineColor"
#      attr_accessor :"vAxis.direction"
#      attr_accessor :"vAxis.format"
#      attr_accessor :"vAxis.logScale"
#      attr_accessor :"vAxis.textPosition"
#      attr_accessor :"vAxis.textStyle"
#      attr_accessor :"vAxis.title"
#      attr_accessor :"vAxis.titleTextStyle"
#      attr_accessor :"vAxis.maxValue"
#      attr_accessor :"vAxis.minValue"
      attr_accessor :width
    end

  end
end