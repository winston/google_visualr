module GoogleVisualr

  class Table < BaseChart

    # http://code.google.com/apis/visualization/documentation/gallery/table.html
    attr_accessor :element_id

    # http://code.google.com/apis/visualization/documentation/gallery/table.html#Configuration_Options
    attr_accessor :allowHtml
    attr_accessor :alternatingRowStyle
    attr_accessor :cssClassNames
    attr_accessor :firstRowNumber
    attr_accessor :height
    attr_accessor :page
    attr_accessor :pageSize
    attr_accessor :rtlTable
    attr_accessor :scrollLeftStartPosition
    attr_accessor :showRowNumber
    attr_accessor :sort
    attr_accessor :sortAscending
    attr_accessor :sortColumn
    attr_accessor :startPage
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