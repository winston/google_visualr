module GoogleVisualr
  module Image

    # http://code.google.com/apis/chart/interactive/docs/gallery/imagelinechart.html
    class LineChart < BaseChart
      include GoogleVisualr::Packages::ImageChart

      # For Configuration Options, please refer to:
      # http://code.google.com/apis/chart/image/docs/gallery/line_charts.html

      # Create URI for a Pie Chart image with sane defaults.  Override by passing in options.
      #
      # Parameters:
      #  *opts         [Optional] Hash of image pie chart options (see http://code.google.com/apis/chart/image/docs/chart_params.html)
      def to_get(opts = {})
        query_params = {}
        
        # Chart Type: default to lc
        query_params[:cht] = "lc"
        
        # Data
        query_params[:chd] = "t:"
        for i in 0..(@data_table.cols.size - 1) do
          query_params[:chd] += "|" if i > 0
          query_params[:chd] += @data_table.get_column(i).join(',')
        end
        
        # Legend
        query_params[:chdl] = @data_table.cols.map{|col| col[:label] }.join('|')
        
        # Axes
        query_params[:chxt] = "x,y"
        
        # Chart Colors
        query_params[:chco] = @options["colors"].join(',').gsub(/#/, '') if @options["colors"]

        super(query_params.merge(opts))
      end
    end

  end
end