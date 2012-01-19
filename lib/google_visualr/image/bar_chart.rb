module GoogleVisualr
  module Image

    # http://code.google.com/apis/chart/interactive/docs/gallery/imagebarchart.html
    class BarChart < BaseChart
      include GoogleVisualr::Packages::ImageChart

      # For Configuration Options, please refer to:
      # http://code.google.com/apis/chart/image/docs/gallery/bar_charts.html

      # Create URI for a bar chart image with sane defaults.  Override by passing in options.
      # (see http://code.google.com/apis/chart/image/docs/chart_params.html)
      #
      # Parameters:
      #  *opts         [Optional] Hash of image bar chart options
      def uri(opts = {})
        query_params = {}
        
        # Chart Type: default to "bvg"
        query_params[:cht] = @options["isStacked"] ? "bvs" : "bvg"
        
        # Data
        query_params[:chd] = "t:"
        for i in 1..(@data_table.cols.size - 1) do
          query_params[:chd] += "|" if i > 1
          query_params[:chd] += @data_table.get_column(i).join(',')
        end
        
        # Legend
        query_params[:chdl] = @data_table.cols[1..-1].map{|col| col[:label] }.join('|')
        
        # Bar Labels
        query_params[:chxl] = "0:|" + @data_table.get_column(0).join('|')
        
        # Axes
        query_params[:chxt] = "x,y"
        
        # Chart Colors (Default to one color per series)
        query_params[:chco] = @options["colors"].join(',').gsub(/#/, '') if @options["colors"]

        chart_image_url(query_params.merge(opts))
      end
    end

  end
end
