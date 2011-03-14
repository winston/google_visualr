module GoogleVisualr
  module Visualizations

    # http://code.google.com/apis/visualization/documentation/gallery/piechart.html
    class PieChart < BaseChart
      include GoogleVisualr::Packages::CoreChart

      attr_accessor :element_id

      # http://code.google.com/apis/visualization/documentation/gallery/piechart.html#Configuration_Options
      attr_accessor :backgroundColor
      attr_accessor :"backgroundColor.stroke"
      attr_accessor :"backgroundColor.strokeWidth"
      attr_accessor :"backgroundColor.fill"
      attr_accessor :chartArea
      attr_accessor :"chartArea.left"
      attr_accessor :"chartArea.top"
      attr_accessor :"chartArea.width"
      attr_accessor :"chartArea.height"
      attr_accessor :colors
      attr_accessor :fontSize
      attr_accessor :fontName
      attr_accessor :height
      attr_accessor :is3D
      attr_accessor :legend
      attr_accessor :legendTextStyle
      attr_accessor :pieSliceText
      attr_accessor :pieSliceTextStyle
      attr_accessor :reverseCategories
      attr_accessor :sliceVisibilityThreshold
      attr_accessor :pieResidueSliceColor
      attr_accessor :pieResidualSliceLabel
      attr_accessor :title
      attr_accessor :titleTextStyle
      attr_accessor :tooltipTextStyle
      attr_accessor :width
    end

  end
end  