module GoogleVisualr
  module Charts

    # http://code.google.com/apis/visualization/documentation/gallery/imagesparkline.html
    class ImageSparkLine < BaseChart

      attr_accessor :element_id

      # http://code.google.com/apis/visualization/documentation/gallery/imagesparkline.html#Configuration_Options
      attr_accessor :color
      attr_accessor :colors
      attr_accessor :fill
      attr_accessor :height
      attr_accessor :labelPosition
      attr_accessor :max
      attr_accessor :min
      attr_accessor :showAxisLines
      attr_accessor :showValueLabels
      attr_accessor :title
      attr_accessor :width
      attr_accessor :layout
    end

  end
end