module GoogleVisualr

  class BaseChart
    include GoogleVisualr::ParamHelpers

    DEFAULT_VERSION = "1.0".freeze

    attr_accessor :data_table, :listeners, :version, :language, :material

    def initialize(data_table, options={})
      @data_table  = data_table
      @listeners   = []
      @version     = options.delete(:version)  || DEFAULT_VERSION
      @language    = options.delete(:language)
      @material    = options.delete(:material) || false
      send(:options=, options)
    end

    def package_name
      self.class.to_s.split("::").last.downcase
    end

    def class_name
      self.class.to_s.split("::").last
    end

    def chart_class
      if material
        "charts"
      else
        "visualization"
      end
    end

    def chart_name
      if material
        class_name.gsub!("Chart", "")
      else
        class_name
      end
    end

    def chart_function_name(element_id)
      "draw_#{element_id.gsub('-', '_')}"
    end

    def options
      @options
    end

    def options=(options)
      @options = stringify_keys!(options)
    end

    def add_listener(event, callback)
      @listeners << { :event => event.to_s, :callback => callback }
    end

    # Generates JavaScript and renders the Google Chart in the final HTML output.
    #
    # Parameters:
    #  *div_id            [Required] The ID of the DIV element that the Google Chart should be rendered in.
    def to_js(element_id)
      js =  ""
      js << "\n<script type='text/javascript'>"
      js << load_js(element_id)
      js << draw_js(element_id)
      js << "\n</script>"
      js
    end

    # Generates JavaScript for loading the appropriate Google Visualization package, with callback to render chart.
    #
    # Parameters:
    #  *div_id            [Required] The ID of the DIV element that the Google Chart should be rendered in.
    def load_js(element_id)
      language_opt = ", language: '#{language}'" if language

      "\n  google.load('visualization', '#{version}', {packages: ['#{package_name}']#{language_opt}, callback: #{chart_function_name(element_id)}});"
    end

    # Generates JavaScript function for rendering the chart.
    #
    # Parameters:
    #  *div_id            [Required] The ID of the DIV element that the Google Chart should be rendered in.
    def draw_js(element_id)
      js = ""
      js << "\n  function #{chart_function_name(element_id)}() {"
      js << "\n    #{@data_table.to_js}"
      js << "\n    var chart = new google.#{chart_class}.#{chart_name}(document.getElementById('#{element_id}'));"
      @listeners.each do |listener|
        js << "\n    google.visualization.events.addListener(chart, '#{listener[:event]}', #{listener[:callback]});"
      end
      js << "\n    chart.draw(data_table, #{js_parameters(@options)});"
      js << "\n  };"
      js
    end
  end

end
