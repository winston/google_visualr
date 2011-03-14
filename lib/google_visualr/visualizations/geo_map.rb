module GoogleVisualr
  module Visualizations

    # http://code.google.com/apis/visualization/documentation/gallery/geomap.html
    class GeoMap < BaseChart

      attr_accessor :element_id

      # http://code.google.com/apis/visualization/documentation/gallery/geomap.html#Configuration_Options
      attr_accessor :region
      attr_accessor :dataMode
      attr_accessor :width
      attr_accessor :height
      attr_accessor :colors
      attr_accessor :showLegend
      attr_accessor :showZoomOut
      attr_accessor :zoomOutLabel
    end

  end
end