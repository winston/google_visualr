module GoogleVisualr

  # http://code.google.com/apis/visualization/documentation/gallery/annotatedtimeline.html
  class AnnotatedTimeLine < BaseChart

    attr_accessor :element_id

    # http://code.google.com/apis/visualization/documentation/gallery/annotatedtimeline.html#Configuration_Options
    attr_accessor :allowHtml
    attr_accessor :allowRedraw
    attr_accessor :allValuesSuffix
    attr_accessor :annotationsWidth
    attr_accessor :colors
    attr_accessor :dateFormat
    attr_accessor :displayAnnotations
    attr_accessor :displayAnnotationsFilter
    attr_accessor :displayDateBarSeparator
    attr_accessor :displayExactValues
    attr_accessor :displayLegendDots
    attr_accessor :displayLegendValues
    attr_accessor :displayRangeSelector
    attr_accessor :displayZoomButtons
    attr_accessor :fill
    attr_accessor :highlightDot
    attr_accessor :legendPosition
    attr_accessor :max
    attr_accessor :min
    attr_accessor :numberFormats
    attr_accessor :scaleColumns
    attr_accessor :scaleType
    attr_accessor :thickness
    attr_accessor :wmode
    attr_accessor :zoomEndTime
    attr_accessor :zoomStartTime

    def render (element_id)

      options = Hash.new

      options[:package]     = self.class.to_s.split('::').last
      options[:element_id]  = element_id
      options[:chart_style] = collect_parameters

      super(options)

    end

  end

end