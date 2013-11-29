module GoogleVisualr

  class DataTable

    attr_accessor :cols
    attr_accessor :rows

    ##############################
    # Constructors
    ##############################
    #
    # GoogleVisualr::DataTable.new
    # Creates an empty data_table instance. Use new_column/s, add_row/s and set_cell methods to populate the data_table.
    #
    # GoogleVisualr::DataTable.new(data_object)
    # Creates a data_table by passing a JavaScript-string-literal like data object into the data parameter. This object can contain formatting options.
    #
    ##############################
    # Syntax Description of a Data Object
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
    #   * p               [Optional] An object that is a map of custom values applied to the cell. Example: :p => { :style => 'border: 1px solid green;' }.
    #
    #   Cells in the row array should be in the same order as their column descriptions in cols.
    #
    #   To indicate a null cell, you can either specify null, or set empty string for a cell in an array, or omit trailing array members.
    #   So, to indicate a row with null for the first two cells, you could specify [ '', '', {cell_val}] or [null, null, {cell_val}].
    def initialize(options = {})
      @cols = Array.new
      @rows = Array.new

       unless options.empty?
         cols = options[:cols]
         new_columns(cols)

         rows = options[:rows]
         rows.each do |row|
           add_row(row[:c])
         end
      end
    end

    # Adds a new column to the data_table.
    # Experimental support for role (and pattern): http://code.google.com/apis/chart/interactive/docs/roles.html.
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
    #   * role            [Optional] A string value that describes the purpose of the data in that column. Example, a column might hold data describing tooltip text, data point annotations, or uncertainty indicators.
    #   * pattern         [Optional] A number (or date) format string specifying how to display the column value; used in conjunction with role.
    def new_column(type, label=nil, id =nil, role=nil, pattern=nil)
      column = { :type => type, :label => label, :id => id, :role => role, :pattern => pattern }.reject { |key, value| value.nil? }
      @cols << column
    end

    # Adds multiple columns to the data_table.
    #
    # Parameters:
    #   * columns         [Required] An array of column objects {:type, :label, :id, :role, :pattern}. Calls new_column for each column object.
    def new_columns(columns)
      columns.each do |column|
        new_column(column[:type], column[:label], column[:id], column[:role], column[:pattern])
      end
    end

    # Sets a column in data_table, specified by column_index with an array of column_values. column_index starts from 0.
    #
    # Parameters
    #   * column_index    [Required] The column to assign column_values. column_index starts from 0.
    #   * column_values   [Required] An array of cell values.
    def set_column(column_index, column_values)
      if @rows.size < column_values.size
        1.upto(column_values.size - @rows.size) { @rows << Array.new }
      end

      column_values.each_with_index do |column_value, row_index|
        set_cell(row_index, column_index, column_value)
      end
    end

    # Gets a column of cell values from the data_table, at column_index. column_index starts from 0.
    #
    # Parameters
    #   * column_index    [Required] The column to retrieve column values. column_index starts from 0.
    def get_column(column_index)
      @rows.transpose[column_index].collect(&:v)
    end

    # Adds a new row to the data_table.
    # Call method without any parameters to add an empty row, otherwise, call method with a row object.
    #
    # Parameters:
    #   * row             [Optional] An array of cell values specifying the data for the new row.
    #     - You can specify a value for a cell (e.g. 'hi') or specify a formatted value using cell objects (e.g. {v:55, f:'Fifty-five'}) as described in the constructor section.
    #     - You can mix simple values and cell objects in the same method call.
    #     - To create an empty cell, use nil or empty string.
    def add_row(row_values=[])
      @rows    << Array.new
      row_index = @rows.size-1

      row_values.each_with_index do |row_value, column_index|
        set_cell(row_index, column_index, row_value)
      end
    end

    # Adds multiple rows to the data_table. You can call this method with data to populate a set of new rows or create new empty rows.
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
        array_or_num.times do
          add_row
        end
      end
    end

    # Gets a row of cell values from the data_table, at row_index. row_index starts from 0.
    #
    # Parameters
    #   * row_index       [Required] The row to retrieve row values. row_index starts from 0.
    def get_row(row_index)
      @rows[row_index].collect(&:v)
    end

    # Sets the value (and formatted value) of a cell.
    #
    # Parameters:
    #   * row_index       [Required] A number greater than or equal to zero, but smaller than the total number of rows.
    #   * column_index    [Required] A number greater than or equal to zero, but smaller than the total number of columns.
    #   * value           [Required] The cell value.
    #                       The data type should match the column data type.
    #                       You can specify a value for a cell (e.g. 'hi').
    #                       Or specify a formatted value using cell objects (e.g. {v:55, f:'Fifty-five'}).
    def set_cell(row_index, column_index, value)
      if within_range?(row_index, column_index)
        verify_against_column_type( @cols[column_index][:type], value )
        @rows[row_index][column_index] = GoogleVisualr::DataTable::Cell.new(value, @cols[column_index][:type])
      else
        raise RangeError, "row_index and column_index MUST be < @rows.size and @cols.size", caller
      end
    end

    # Gets a cell value from the visualization, at row_index, column_index. row_index and column_index start from 0.
    #
    # Parameters:
    #   * row_index       [Required] row_index starts from 0.
    #   * column_index    [Required] column_index starts from 0.
    def get_cell(row_index, column_index)
      if within_range?(row_index, column_index)
        @rows[row_index][column_index].v
      else
        raise RangeError, "row_index and column_index MUST be < @rows.size and @cols.size", caller
      end
    end

    # Applies one or more formatters to the data_table to format the columns as specified by the formatter/s.
    #
    # Parameters:
    #   * formatter/s     [Required] One, or an array of formatters.
    def format(*formatters)
      @formatters ||= Array.new
      @formatters  += formatters
    end

    # Returns the JavaScript equivalent for this data_table instance.
    def to_js
      js = "var data_table = new google.visualization.DataTable();"

      @cols.each do |column|
        js << "data_table.addColumn("
        js << display(column)
        js << ");"
      end

      @rows.each do |row|
        js << "data_table.addRow("
        js << "[#{row.map(&:to_js).join(", ")}]" unless row.empty?
        js << ");"
      end

      if @formatters
        @formatters.each do |formatter|
          js << formatter.to_js
        end
      end

      js
    end

    private

    def display(column)
      column[:type] = "datetime" if column[:type] == "time"
      column.to_json
    end

    def within_range?(row_index, column_index)
      row_index < @rows.size && column_index < @cols.size
    end

    def verify_against_column_type(type, value)
      v = value.is_a?(Hash) ? value[:v] : value

      case
        when v.nil?
          return
        when type == "string"
          raise ArgumentError, "cell value '#{v}' is not a String", caller              unless v.is_a?(String)
        when type == "number"
          raise ArgumentError, "cell value '#{v}' is not an Integer, Float or BigDecimal", caller unless v.is_a?(Integer) || v.is_a?(Float) || v.is_a?(BigDecimal)
        when type == "boolean"
          raise ArgumentError, "cell value '#{v}' is not a Boolean", caller             unless v.is_a?(TrueClass) || v.is_a?(FalseClass)
        when type == 'datetime'
          raise ArgumentError, "cell value '#{v}' is not a DateTime", caller            unless v.is_a?(DateTime)  || v.is_a?(Time)
        when type == 'time'
          raise ArgumentError, "cell value '#{v}' is not a DateTime", caller            unless v.is_a?(DateTime)  || v.is_a?(Time)
        when type == "date"
          raise ArgumentError, "cell value '#{v}' is not a Date", caller                unless v.is_a?(Date)
      end
    end

    class Cell
      include GoogleVisualr::ParamHelpers

      attr_accessor :v # value
      attr_accessor :f # formatted
      attr_accessor :p # properties

      def initialize(options, type = nil)
        if options.is_a?(Hash)
          @v = options[:v]
          @f = options[:f]
          @p = options[:p]
          @type = type
        else # should be a string
          @v = options
          @type = type
        end
      end

      def to_js
        return "null" if @v.nil? && @f.nil? && @p.nil?

        js  = "{"
        js << "v: #{typecast(@v, @type)}"
        js << ", f: #{typecast(@f)}"  unless @f.nil?
        js << ", p: #{typecast(@p)}"  unless @p.nil?
        js << "}"

        js
      end

    end

  end

end
