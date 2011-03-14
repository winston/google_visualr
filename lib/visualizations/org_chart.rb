module GoogleVisualr

  # http://code.google.com/apis/visualization/documentation/gallery/orgchart.html
  class OrgChart < BaseChart

    attr_accessor :element_id

    # http://code.google.com/apis/visualization/documentation/gallery/orgchart.html#Configuration_Options
    attr_accessor :allowCollapse
    attr_accessor :allowHtml
    attr_accessor :nodeClass
    attr_accessor :selectedNodeClass
    attr_accessor :size

    def render (element_id)

      options = Hash.new

      options[:package]     = self.class.to_s.split('::').last
      options[:element_id]  = element_id
      options[:chart_style] = collect_parameters

      super(options)

    end

  end

end