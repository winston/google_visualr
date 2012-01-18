module GoogleVisualr

  class BaseChart
    include GoogleVisualr::Packages
    include GoogleVisualr::ParamHelpers

    attr_accessor :data_table

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

    # Generates JavaScript and renders the Google Chart in the final HTML output.
    #
    # Parameters:
    #  *div_id            [Required] The ID of the DIV element that the Google Chart should be rendered in.
    def to_js(element_id)
      js  = "\n<script type='text/javascript'>"
      js << "\n  google.load('visualization','1', {packages: ['#{package_name}'], callback: function() {"
      js << "\n    #{@data_table.to_js}"
      js << "\n    var chart = new google.visualization.#{class_name}(document.getElementById('#{element_id}'));"
      js << "\n    chart.draw(data_table, #{js_parameters(@options)});"
      js << "\n  }});"
      js << "\n</script>"

      js
    end

    # Define some defaults that if missing would cause failure
    IMAGE_DEFAULTS = {
      # Automatic Scaling
      :chds => "a",
      # Size must be defined
      :chs => "500x500"
    }

    # Generates HTTP GET URL for the chart image
    #
    # Parameters:
    #  *opts         [Optional] Hash of standard chart options (see http://code.google.com/apis/chart/image/docs/chart_params.html)
    def to_get(opts = {})
      
      #####
      # Standard image chart options and sane defaults
      query_params = IMAGE_DEFAULTS
      # Size
      if @options["height"] && @options["width"]
        query_params[:chs] = "#{@options["height"]}x#{@options["width"]}"
      end
      # Title
      query_params[:chtt] = @options["title"] if @options["title"]
      # Title Formatting
      query_params[:chts] = "#{@options["titleTextStyle"][:color].gsub(/#/, '')},#{@options["titleTextStyle"][:fontSize]}" if @options["titleTextStyle"]
      # Legend Formatting
      query_params[:chdls] = "#{@options["legendTextStyle"][:color].gsub(/#/, '')},#{@options["legendTextStyle"][:fontSize]}" if @options["legendTextStyle"]
      #####
      
      query_params = stringify_keys!(query_params.merge(opts))
      base_url = "https://chart.googleapis.com/chart"
      query = ""
      i = 0
      query_params.each do |k, v|
        query += (i == 0) ? "?" : "&"
        query += "#{k}=#{CGI.escape(v)}"
        i += 1
      end
      URI.parse(base_url + query)
    end

  end

end