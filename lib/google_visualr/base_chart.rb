module GoogleVisualr

  class BaseChart
    include GoogleVisualr::Packages

    attr_accessor :data_table
    attr_accessor :formatters


    def initialize(data_table, options={})
      @data_table = data_table
      set_options(options)
    end

    # Sets chart configuration options with a hash.
    #
    # Parameters:
    #  *options            [Required] A hash of configuration options.
    def set_options(options)

      options.each_pair do | key, value |
        send "#{key}=", value
      end

    end

    # Applies one or more formatters to the visualization to format the columns as specified by the formatter/s.
    #
    # Parameters:
    #   * formatter/s     [Required] One, or an array of formatters.
    def format(*formatters)

      @formatters ||= Array.new
      @formatters  += formatters

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
      js << "\n    chart.draw(chart_data, #{collect_parameters});"
      js << "\n  }});"
      js << "\n</script>"

      js

    end

    private
    
    def class_name
      self.class.to_s.split('::').last
    end

    def collect_parameters

      attributes = Array.new
      instance_variable_names.each do |instance_variable|
        next if instance_variable == "@chart_data" || instance_variable == "@formatters"
        key         = instance_variable.gsub("@", "")
        value       = instance_variable_get(instance_variable)
        attribute   = "#{key}:#{typecast(value)}"
        attributes << attribute
      end

      "{" + attributes.join(",") + "}"

    end

  end

end