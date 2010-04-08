module GoogleVisualr

  # http://code.google.com/apis/visualization/documentation/gallery/map.html
  class Map < BaseChart

    attr_accessor :element_id

    # http://code.google.com/apis/visualization/documentation/gallery/map.html#Configuration_Options
    attr_accessor :enableScrollWheel
    attr_accessor :showTip
    attr_accessor :showLine
    attr_accessor :lineColor
    attr_accessor :lineWidth
    attr_accessor :mapType
    attr_accessor :zoomLevel

    def render (element_id)

      options = Hash.new

      options[:package]     = self.class.to_s.split('::').last
      options[:element_id]  = element_id
      options[:chart_style] = collect_parameters

      super(options)

    end

  end

end