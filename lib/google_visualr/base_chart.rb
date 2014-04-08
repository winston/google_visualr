module GoogleVisualr

  class BaseChart
    include GoogleVisualr::Packages
    include GoogleVisualr::ParamHelpers

    attr_accessor :data_table, :listeners

    def initialize(data_table, options={})
      @data_table = data_table
      send(:options=, options)
      @listeners  = []
    end

    def chart_name
      class_name
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
      "\n  google.load('visualization','1', {packages: ['#{package_name}'], callback: #{chart_function_name(element_id)}});"
    end

    # Generates JavaScript function for rendering the chart.
    #
    # Parameters:
    #  *div_id            [Required] The ID of the DIV element that the Google Chart should be rendered in.
    def draw_js(element_id)
      js = ""
      js << "\n  function #{chart_function_name(element_id)}() {"
      js << "\n    #{@data_table.to_js}"
      js << "\n    var chart = new google.visualization.#{chart_name}(document.getElementById('#{element_id}'));"
      @listeners.each do |listener|
        js << "\n    google.visualization.events.addListener(chart, '#{listener[:event]}', #{listener[:callback]});"
      end
      js << "\n    chart.draw(data_table, #{js_parameters(@options)});"
      js << "\n  };"
      js
    end
  end

end
