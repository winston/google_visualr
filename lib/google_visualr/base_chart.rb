module GoogleVisualr

  class BaseChart
    include GoogleVisualr::Packages
    include GoogleVisualr::TypeCaster

    attr_accessor :data_table
    attr_accessor :formatters

    def initialize(data_table, options={})
      @data_table = data_table
      send(:options=, options)
    end

    def options
      @options
    end

    def options=(options)
      @options = stringify_keys!(options)
    end

    # Generates JavaScript and renders the visualization in the final HTML output.
    #
    # Parameters:
    #  *div_id            [Required] The ID of the DIV element that the visualization should be rendered in.
    def to_js(element_id)
      js  = "\n<script type='text/javascript'>"
      js << "\n  google.load('visualization','1', {packages: ['#{package_name}'], callback: function() {"

      js << "\n    #{@data_table.to_js}"

      if @formatters
        @formatters.each do |formatter|
          js << formatter.script
        end
      end

      js << "\n    var chart = new google.visualization.#{class_name}(document.getElementById('#{element_id}'));"
      js << "\n    chart.draw(chart_data, #{js_parameters});"
      js << "\n  }});"
      js << "\n</script>"
      js
    end

    private

    def class_name
      self.class.to_s.split('::').last
    end

    def js_parameters
      attributes = @options.collect { |(key, value)| "#{key}: #{typecast(value)}" }
      "{" + attributes.join(", ") + "}"
    end
  end

end