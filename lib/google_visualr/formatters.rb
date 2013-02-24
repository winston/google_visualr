module GoogleVisualr

  # http://code.google.com/apis/chart/interactive/docs/reference.html#formatters
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
      js   = "\nvar formatter = new google.visualization.#{self.class.to_s.split('::').last}("
      js  <<  js_parameters(@options)
      js  << ");"

      yield js if block_given?

      @columns.each do |column|
       js << "\nformatter.format(data_table, #{column});"
      end

      js
    end

  end

  class ArrowFormat  < Formatter
  end

  class BarFormat    < Formatter
  end

  class ColorFormat  < Formatter

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
      super do |js|
        @ranges.each do |r|
          js << "\nformatter.addRange(#{typecast(r[:from])}, #{typecast(r[:to])}, #{typecast(r[:color])}, #{typecast(r[:bgcolor])});"
        end
        @gradient_ranges.each do |r|
          js << "\nformatter.addGradientRange(#{typecast(r[:from])}, #{typecast(r[:to])}, #{typecast(r[:color])}, #{typecast(r[:fromBgColor])}, #{typecast(r[:toBgColor])});"
        end
      end
    end
  end

  class DateFormat   < Formatter
  end

  class NumberFormat < Formatter
  end

end