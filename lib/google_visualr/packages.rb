module GoogleVisualr
  module Packages
    module CoreChart
      def package_name
        "corechart"
      end
    end

    module ImageChart
      def package_name
        "image#{self.class.to_s.split("::").last.downcase}"
      end
      def class_name
        "Image#{self.class.to_s.split('::').last}"
      end

      # Set defaults according to http://code.google.com/apis/chart/interactive/docs/gallery/genericimagechart.html#Configuration_Options
      IMAGE_DEFAULTS = {
        # Automatic Scaling
        :chds => "a",
        # Size
        :chs => "400x200",
        # Axes
        :chxt => "x,y"
      }

      # Generates HTTP GET URL for the chart image
      #
      # Parameters:
      #  *opts         [Optional] Hash of standard chart options (see http://code.google.com/apis/chart/image/docs/chart_params.html)
      def chart_image_url(superseding_params = {})

        #####
        # Generic image chart defaults
        query_params = IMAGE_DEFAULTS.clone

        # backgroundColor
        query_params[:chf] = "bg,s," + options["backgroundColor"].gsub(/#/, '') if options["backgroundColor"]

        # color, colors ('color' param is ignored if 'colors' is present)
        if options["colors"]
          query_params[:chco] = options["colors"].join(',').gsub(/#/, '')
        elsif options["color"]
          query_params[:chco] = options["color"].gsub(/#/, '')
        end

        # fill (this will often not look good - better for user to override this parameter)
        query_params[:chm] = "B,#{query_params[:chco].split(',').first},0,0,0" if options["fill"] && query_params[:chco]

        # firstHiddenColumn, singleColumnDisplay, data
        firstHiddenColumn = options["firstHiddenColumn"] ? options["firstHiddenColumn"] : data_table.cols.size - 1
        query_params[:chd] = "t:"
        unless options["singleColumnDisplay"]
          for i in 1..firstHiddenColumn do
            query_params[:chd] += "|" if i > 1
            query_params[:chd] += data_table.get_column(i).join(',')
          end
        else
          query_params[:chd] += data_dable.get_column(options["singleColumnDisplay"])
        end

        # height, width
        if options["height"] && options["width"]
          query_params[:chs] = "#{options["width"]}x#{options["height"]}"
        end

        # title
        query_params[:chtt] = options["title"] if options["title"]

        # legend
        unless options["legend"] == 'none'
          query_params[:chdlp] = options["legend"].first unless options["legend"].blank?
          query_params[:chdl] = data_table.cols[1..-1].map{|col| col[:label] }.join('|')
        else
          query_params.delete(:chdlp)
          query_params.delete(:chdl)
        end

        # min, max, valueLabelsInterval (works as long as :chxt => "x,y" and both 'min' and 'max' are set)
        if options["min"] && options["max"]
          query_params[:chxr] = "1,#{options['min']},#{options['max']}"
          query_params[:chxr] += ",#{options['valueLabelsInterval']}" if options['valueLabelsInterval']
          query_params[:chds] = "#{options['min']},#{options['max']}"
        end
        #####

        query_params = stringify_keys!(query_params.merge(superseding_params))
        base_url = "https://chart.googleapis.com/chart"
        query = ""
        query_params.each_with_index do |(k,v),i|
          query += (i == 0) ? "?" : "&"
          query += "#{k}=#{CGI.escape(v)}"
        end
        URI.parse(base_url + query)
      end
    end
  end
end
