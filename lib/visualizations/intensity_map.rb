module GoogleVisualr

  # http://code.google.com/apis/visualization/documentation/gallery/intensitymap.html
  class IntensityMap < BaseChart

    attr_accessor :element_id

    # http://code.google.com/apis/visualization/documentation/gallery/intensitymap.html#Configuration_Options
    attr_accessor :colors
    attr_accessor :height
    attr_accessor :region
    attr_accessor :showOneTab
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