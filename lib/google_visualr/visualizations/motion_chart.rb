module GoogleVisualr
  module Visualizations

    # http://code.google.com/apis/visualization/documentation/gallery/motionchart.html
    class MotionChart < BaseChart

      attr_accessor :element_id

      # http://code.google.com/apis/visualization/documentation/gallery/motionchart.html#Configuration_Options
      attr_accessor :height
      attr_accessor :width
      attr_accessor :state
      attr_accessor :showChartButtons
      attr_accessor :showHeader
      attr_accessor :showSelectListComponent
      attr_accessor :showSidePanel
      attr_accessor :showXMetricPicker
      attr_accessor :showYMetricPicker
      attr_accessor :showXScalePicker
      attr_accessor :showYScalePicker
      attr_accessor :showAdvancedPanel
    end

  end  
end