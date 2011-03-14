module GoogleVisualr
  module Visualizations

    # http://code.google.com/apis/visualization/documentation/gallery/map.html
    class Map < BaseChart

      attr_accessor :element_id

      # http://code.google.com/apis/visualization/documentation/gallery/map.html#Configuration_Options
      attr_accessor :enableScrollWheel
      attr_accessor :showTip
      attr_accessor :showLine
      attr_accessor :lineColor
      attr_accessor :lineWidth
      attr_accessor :useMapTypeControl
      attr_accessor :zoomLevel
    end
    
  end
end