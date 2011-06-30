module GoogleVisualr

  # http://code.google.com/apis/visualization/documentation/reference.html#formatters
  class Formatter
    include GoogleVisualr::ParamHelpers

    def initialize(options={})
      @options = options
    end


    def columns(*columns)
      @columns = columns.flatten
    end

    def options(*options)
      @options = stringify_keys!(options.pop)
    end

    def to_js(&block)
      script   = "\nvar formatter = new google.visualization.#{self.class.to_s.split('::').last}("
      script  <<  js_parameters(@options)
      script  << ");"

      yield script if block_given?

      @columns.each do |column|
       script << "\nformatter.format(data_table, #{column});"
      end

      script
    end

  end

  class ArrowFormat < Formatter
  end

  class BarFormat   < Formatter
  end

  class ColorFormat < Formatter

    attr_accessor :ranges
    attr_accessor :gradient_ranges

    def initialize
      @ranges           = Array.new
      @gradient_ranges  = Array.new
    end

    def add_range(from, to, color, bgcolor)
      @ranges << { :from => from, :to => to, :color => color, :bgcolor => bgcolor }
    end

    def add_gradient_range(from, to, color, fromBgColor, toBgColor)
      @gradient_ranges <<  { :from => from, :to => to, :color => color, :fromBgColor => fromBgColor, :toBgColor => toBgColor }
    end

    def to_js
      super do |script|
        @ranges.each do |r|
          script << "\nformatter.addRange(#{typecast(r[:from])}, #{typecast(r[:to])}, '#{r[:color]}', '#{r[:bgcolor]}');"
        end

        @gradient_ranges.each do |r|
          script << "\nformatter.addGradientRange(#{typecast(r[:from])}, #{typecast(r[:to])}, '#{r[:color]}', '#{r[:fromBgColor]}', '#{r[:toBgColor]}');"
        end
      end
    end
  end

  class DateFormat  < Formatter
  end

  class NumberFormat < Formatter
  end

end