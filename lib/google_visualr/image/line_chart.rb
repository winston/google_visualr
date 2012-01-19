module GoogleVisualr
  module Image

    # http://code.google.com/apis/chart/interactive/docs/gallery/imagelinechart.html
    class LineChart < BaseChart
      include GoogleVisualr::Packages::ImageChart

      # For Configuration Options, please refer to:
      # http://code.google.com/apis/chart/image/docs/gallery/line_charts.html

      # Create URI for a line chart image with sane defaults.  Override by passing in options.
      # (see http://code.google.com/apis/chart/image/docs/chart_params.html)
      #
      # Parameters:
      #  *opts         [Optional] Hash of image line chart options
      def uri(opts = {})
        query_params = {}
        
        # Chart Type: default to lc
        query_params[:cht] = "lc"
        
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
        
        # Chart Colors
        query_params[:chco] = @options["colors"].join(',').gsub(/#/, '') if @options["colors"]

        chart_image_url(query_params.merge(opts))
      end
    end

  end
end