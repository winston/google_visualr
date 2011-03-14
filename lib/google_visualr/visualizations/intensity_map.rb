module GoogleVisualr
  module Visualizations

    # http://code.google.com/apis/visualization/documentation/gallery/intensitymap.html
    class IntensityMap < BaseChart

      attr_accessor :element_id

      # http://code.google.com/apis/visualization/documentation/gallery/intensitymap.html#Configuration_Options
      attr_accessor :colors
      attr_accessor :height
      attr_accessor :region
      attr_accessor :showOneTab
      attr_accessor :width
    end

  end  
end