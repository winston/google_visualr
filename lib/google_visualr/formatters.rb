module GoogleVisualr

  # http://code.google.com/apis/visualization/documentation/reference.html#formatters
  class Formatter

    attr_accessor :columns

    def initialize(options={})

      options.each_pair do | key, value |
        self.send "#{key}=", value
      end

    end

    def columns(*columns)
      @columns = columns.flatten
    end

    def script(options)

      script   = "var formatter = new google.visualization.#{options[:formatter]}("
      script  <<  options[:formatter_options]
      script  << ");"

      @columns.each do |column|
       script << "formatter.format(chart_data, #{column});"
      end

      return script

    end

    def collect_parameters

      attributes = Array.new
      instance_variable_names.each do |instance_variable|
        next if instance_variable == "@columns"
        key         = instance_variable.gsub("@", "")
        value       = instance_variable_get(instance_variable)
        attribute   = key + ":" + (value.is_a?(String) ? "'" + value + "'" : value.to_s)
        attributes << attribute
      end

      return "{" + attributes.join(",") + "}"

    end

  end

  class ArrowFormat < Formatter

    attr_accessor :base

    def script

      options = Hash.new
      options[:formatter]         = self.class.to_s.split('::').last
      options[:formatter_options] = collect_parameters

      super(options)

    end

  end

  class BarFormat   < Formatter

    attr_accessor :base
    attr_accessor :colorNegative
    attr_accessor :colorPositive
    attr_accessor :drawZeroLine
    attr_accessor :max
    attr_accessor :min
    attr_accessor :showValue
    attr_accessor :width

    def script

      options = Hash.new
      options[:formatter]         = self.class.to_s.split('::').last
      options[:formatter_options] = collect_parameters

      super(options)

    end

  end

  class ColorFormat < Formatter

    attr_accessor :ranges
    attr_accessor :gradient_ranges

    def initialize
      @ranges           = Array.new
      @gradient_ranges  = Array.new
    end

    def add_range(from, to, color, bgcolor)

      options = { :from => from, :to => to, :color => color, :bgcolor => bgcolor }
      [:from, :to].each do |attr|
        options[attr] ||= 'null'
      end

      @ranges           << options

    end

    def add_gradient_range(from, to, color, fromBgColor, toBgColor)

      options = { :from => from, :to => to, :color => color, :fromBgColor => fromBgColor, :toBgColor => toBgColor }
      [:from, :to].each do |attr|
        options[attr] ||= 'null'
      end

      @gradient_ranges  << options

    end

    def script

      script  = "var formatter = new google.visualization.ColorFormat();"

      @ranges.each do |r|
        script << "formatter.addRange( #{r[:from]}, #{r[:to]}, '#{r[:color]}', '#{r[:bgcolor]}' );"
      end

      @gradient_ranges.each do |r|
        script << "formatter.addGradientRange( #{r[:from]}, #{r[:to]}, '#{r[:color]}', '#{r[:fromBgColor]}', '#{r[:toBgColor]}' );"
      end

      @columns.each do |column|
        script << "formatter.format(chart_data, #{column});"
      end

      return script

    end

  end

  class DateFormat  < Formatter

    attr_accessor :formatType
    attr_accessor :pattern
    attr_accessor :timeZone

    def script

      options = Hash.new
      options[:formatter]         = self.class.to_s.split('::').last
      options[:formatter_options] = collect_parameters

      super(options)

    end

  end

  class NumberFormat < Formatter

    attr_accessor :decimalSymbol
    attr_accessor :fractionDigits
    attr_accessor :groupingSymbol
    attr_accessor :negativeColor
    attr_accessor :negativeParens
    attr_accessor :prefix
    attr_accessor :suffix

    def script

      options = Hash.new
      options[:formatter]         = self.class.to_s.split('::').last
      options[:formatter_options] = collect_parameters

      super(options)

    end

  end

end