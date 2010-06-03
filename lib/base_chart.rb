module GoogleVisualr

  class BaseChart

    attr_accessor :chart_data
    attr_accessor :formatters

    ##############################
    # Constructors
    ##############################
    #
    # GoogleVisualr::visualization.new:
    # Creates an empty visualization instance. Use add_columns, add_rows and set_value or set_cell methods to populate the visualization.
    #
    # GoogleVisualr::visualization.new(data object):
    # reates a visualization by passing a JavaScript-string-literal like data object into the data parameter. This object can contain formatting options.
    #
    ##############################
    # Syntax Description of Data Object
    ##############################
    #
    # The data object consists of two required top-level properties, cols and rows.
    #
    # * cols property
    #
    #   cols is an array of objects describing the ID and type of each column. Each property is an object with the following properties (case-sensitive):
    #
    #   * type            [Required] The data type of the data in the column. Supports the following string values:
    #     - 'string'    : String value. Example values: v:'foo', :v:'bar'
    #     - 'number'    : Number value. Example values: v:7, v:3.14, v:-55
    #     - 'boolean'   : Boolean value ('true' or 'false'). Example values: v:true, v:false
    #     - 'date'      : Date object, with the time truncated. Example value: v:Date.parse('2010-01-01')
    #     - 'datetime'  : DateTime/Time object, time inclusive. Example value: v:DateTime.parse('2010-01-01 14:20:25')
    #     - 'timeofday' : Array of 3 numbers or 4 numbers, [Hour,Minute,Second,(Optional) Milliseconds]. Example value: v:[8, 15, 0]
    #   * label           [Optional] A string value that some visualizations display for this column. Example: label:'Height'
    #   * id              [Optional] A unique (basic alphanumeric) string ID of the column. Be careful not to choose a JavaScript keyword. Example: id:'col_1'
    #
    # * rows property
    #
    #   The rows property holds an array of row objects. Each row object has one required property called c, which is an array of cells in that row.
    #
    #   Each cell in the table is described by an object with the following properties:
    #
    #   * v               [Optional] The cell value. The data type should match the column data type.
    #   * f               [Optional] A string version of the v value, formatted strictly for display only. If omitted, a string version of v will be used.
    #
    #   Cells in the row array should be in the same order as their column descriptions in cols.
    #
    #   To indicate a null cell, you can either specify null, or set empty string for a cell in an array, or omit trailing array members.
    #   So, to indicate a row with null for the first two cells, you could specify [ '', '', {cell_val}] or [null, null, {cell_val}].
    def initialize(options={})

      @chart_data  = "var chart_data = new google.visualization.DataTable();"

      if !options.empty?

        cols = options[:cols]
        add_columns(cols)

        rows = options[:rows]
        rows.each do |row|
          add_row(row[:c])
        end

      end

    end

    # Adds a new column to the visualization.
    #
    # Parameters:
    #   * type            [Required] The data type of the data in the column. Supports the following string values:
    #     - 'string'    : String value. Example values: v:'hello'
    #     - 'number'    : Number value. Example values: v:7 , v:3.14, v:-55
    #     - 'date'      : Date object, with the time truncated. Example values: v:Date.parse('2010-01-01')
    #     - 'datetime'  : Date object including the time. Example values: v:Date.parse('2010-01-01 14:20:25')
    #     - 'boolean'   : Boolean value ('true' or 'false'). Example values: v: true
    #   * label           [Optional] A string value that some visualizations display for this column. Example: label:'Height'
    #   * id              [Optional] A unique (basic alphanumeric) string ID of the column. Be careful not to choose a JavaScript keyword. Example: id:'col_1'
    def add_column (type, label="", id="")
      @chart_data << "chart_data.addColumn('#{type}', '#{label}', '#{id}');"
    end

    # Adds multiple columns to the visualization.
    #
    # Parameters:
    #   * columns         [Required] An array of column objects {:type, :label, :id}. Calls add_column for each column object.
    def add_columns(columns)

      columns.each do |column|
        add_column(column[:type], column[:label], column[:id])
      end

    end

    # Adds a new row to the visualization.
    # Call method without any parameters to add an empty row, otherwise, call method with a row object.
    #
    # Parameters:
    #   * row             [Optional] An array of cell values specifying the data for the new row.
    #     - You can specify a value for a cell (e.g. 'hi') or specify a formatted value using cell objects (e.g. {v:55, f:'Fifty-five'}) as described in the constructor section.
    #     - You can mix simple values and cell objects in the same method call.
    #     - To create an empty cell, use nil or empty string.
    def add_row(row)

      if row.empty?
        @chart_data << "chart_data.addRow();"  # Empty Row
      else

        attributes = Array.new
        row.each do |cell|
          attributes << add_row_cell(cell)
        end

        @chart_data << "chart_data.addRow( [" +  attributes.join(",")  + "] );"

      end

    end

    # Adds multiple rows to the visualization. You can call this method with data to populate a set of new rows or create new empty rows.
    #
    # Parameters:
    #   * array_or_num    [Required] Either an array or a number.
    #     - Array: An array of row objects used to populate a set of new rows. Each row is an object as described in add_row().
    #     - Number: A number specifying the number of new empty rows to create.
    def add_rows(array_or_num)

      if array_or_num.is_a?(Array)
        array_or_num.each do |row|
          add_row(row)
        end
      else
        @chart_data << "chart_data.addRows(#{array_or_num});"
      end

    end

    # Sets the value and/or formatted value of a cell.
    #
    # Parameters:
    #   * row_index       [Required] A number greater than or equal to zero, but smaller than the total number of rows.
    #   * column_index    [Required] A number greater than or equal to zero, but smaller than the total number of columns.
    #   * value           [Required] The cell value. The data type should match the column data type.
    #   * formatted_value [Optional] A string version of value, formatted strictly for display only. If omitted, a string version of value will be used.
    def set_cell  (row_index, column_index, value, formatted_value=nil, properties=nil)

      @chart_data << "chart_data.setCell("
      @chart_data << "#{row_index}, #{column_index}, #{typecast(value)}"
      @chart_data << ", '#{formatted_value}'" unless formatted_value.blank?
      @chart_data << ", '#{properties}'"      unless properties.blank?
      @chart_data << ");"

    end

    # Sets the value of a cell. Overwrites any existing cell value, and clear out any formatted value for the cell.
    #
    # Parameters:
    #   * row_index       [Required] A number greater than or equal to zero, but smaller than the total number of rows.
    #   * column_index    [Required] A number greater than or equal to zero, but smaller than the total number of columns.
    #   * value           [Required] The cell value. The data type should match the column data type.
    def set_value (row_index, column_index, value)

      @chart_data << "chart_data.setCell(#{row_index}, #{column_index}, #{typecast(value)});"

    end

    # Applies one or more formatters to the visualization to format the columns as specified by the formatter/s.
    #
    # Parameters:
    #   * formatter/s     [Required] One, or an array of formatters.
    def format(*formatters)

      @formatters ||= Array.new
      @formatters  += formatters

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

    # Generates JavaScript and renders the visualization in the final HTML output.
    #
    # Parameters:
    #  *div_id            [Required] The ID of the DIV element that the visualization should be rendered in.
    #
    # Note: This is the super method.
    def render(options)

      script  = "\n<script type='text/javascript'>"
      script << "\n  google.load('visualization','1', {packages: ['#{options[:package].downcase}'], callback: function() {"
      script << "\n    #{@chart_data}"
      if @formatters
        @formatters.each do |formatter|
          script << formatter.script
        end
      end
      script << "\n    var chart = new google.visualization.#{options[:package]}(document.getElementById('#{options[:element_id]}'));"
      script << "\n    chart.draw(chart_data, #{options[:chart_style]});"
      script << "\n  }});"
      script << "\n</script>"

      return script

    end

    private

    def add_row_cell(cell)

      if cell.is_a?(Hash)

        attributes = Array.new
        cell.each_pair do |key, value|
          attributes << "#{key}: #{typecast(value)}"
        end

        return "{" + attributes.join(",") + "}"

      else
        return "#{typecast(cell)}"
      end

    end

    # If the column type is 'string'    , the value should be a string.
    # If the column type is 'number'    , the value should be a number.
    # If the column type is 'boolean'   , the value should be a boolean.
    # If the column type is 'date'      , the value should be a Date object.
    # If the column type is 'datetime'  , the value should be a DateTime or Time object.
    # If the column type is 'timeofday' , the value should be an array of three or four numbers: [hour, minute, second, optional milliseconds].
    def typecast(value)

      case
        when value.is_a?(String)
          return "'#{escape_single_quotes(value)}'"
        when value.is_a?(Integer)   || value.is_a?(Float)
          return value
        when value.is_a?(TrueClass) || value.is_a?(FalseClass)
          return "#{value}"
        when value.is_a?(Date)
          return "new Date(#{value.year}, #{value.month-1}, #{value.day})"
        when value.is_a?(DateTime)  ||  value.is_a?(Time)
          return "new Date(#{value.year}, #{value.month-1}, #{value.day}, #{value.hour}, #{value.min}, #{value.sec})"
        when value.is_a?(Array)
          return "[" + value.collect { |item| typecast(item) }.join(",") + "]"
        else
          return value
      end

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

      return "{" + attributes.join(",") + "}"

    end

    def escape_single_quotes(str)

      str.gsub(/[']/, '\\\\\'')

    end

  end

end