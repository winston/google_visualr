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

    # If the column type is 'string'    , the value should be a string.
    # If the column type is 'number'    , the value should be a number.
    # If the column type is 'boolean'   , the value should be a boolean.
    # If the column type is 'date'      , the value should be a Date object.
    # If the column type is 'datetime'  , the value should be a DateTime or Time object.
    # If the column type is 'timeofday' , the value should be an array of three or four numbers: [hour, minute, second, optional milliseconds].
    def typecast(value)

      case
        when value.is_a?(String)
          return "'#{value.gsub(/[']/, '\\\\\'')}'"
        when value.is_a?(Integer)   || value.is_a?(Float)
          return value
        when value.is_a?(TrueClass) || value.is_a?(FalseClass)
          return "#{value}"
        when value.is_a?(Date)
          return "new Date(#{value.year}, #{value.month-1}, #{value.day})"
        when value.is_a?(DateTime)  ||  value.is_a?(Time)
          return "new Date(#{value.year}, #{value.month-1}, #{value.day}, #{value.hour}, #{value.min}, #{value.sec})"
        else
          return value
      end

    end

    def class_name
      self.class.to_s.split('::').last
    end

    def collect_parameters

      attributes = Array.new
      instance_variables.map(&:to_s).each do |instance_variable|
        next if instance_variable == "@data_table" || instance_variable == "@formatters"
        key         = instance_variable.gsub("@", "")
        value       = instance_variable_get(instance_variable)
        attribute   = "#{key}:#{typecast(value)}"
        attributes << attribute
      end

      "{" + attributes.join(",") + "}"

    end

  end

end