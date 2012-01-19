module GoogleVisualr

  module Packages

    def package_name
      self.class.to_s.split("::").last.downcase
    end

    def class_name
      self.class.to_s.split('::').last
    end

    module CoreChart
      def package_name
        "corechart"
      end
    end

    module ImageChart
      include GoogleVisualr::ParamHelpers

      def package_name
        "image#{self.class.to_s.split("::").last.downcase}"
      end
      def class_name
        "Image#{self.class.to_s.split('::').last}"
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
      def chart_image_url(superseding_options = {})

        #####
        # Standard image chart options and sane defaults
        query_params = IMAGE_DEFAULTS

        # Size
        if options["height"] && options["width"]
          query_params[:chs] = "#{options["height"]}x#{options["width"]}"
        end

        # Title
        query_params[:chtt] = options["title"] if options["title"]

        # Title Formatting
        query_params[:chts] = "#{options["titleTextStyle"][:color].gsub(/#/, '')},#{options["titleTextStyle"][:fontSize]}" if options["titleTextStyle"]

        # Legend Formatting
        query_params[:chdls] = "#{options["legendTextStyle"][:color].gsub(/#/, '')},#{options["legendTextStyle"][:fontSize]}" if options["legendTextStyle"]
        #####

        query_params = stringify_keys!(query_params.merge(superseding_options))
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

end