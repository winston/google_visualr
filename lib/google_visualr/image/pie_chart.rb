module GoogleVisualr
  module Image

    # http://code.google.com/apis/chart/interactive/docs/gallery/imagepiechart.html
    class PieChart < BaseChart
      include GoogleVisualr::Packages::ImageChart

      # For Configuration Options, please refer to:
      # http://code.google.com/apis/chart/image/docs/gallery/pie_charts.html
      
      # Create URI for a pie chart image with sane defaults.  Override by passing in options.
      # (see http://code.google.com/apis/chart/image/docs/chart_params.html)
      #
      # Parameters:
      #  *opts         [Optional] Hash of image pie chart options
      def uri(opts = {})
        query_params = {}
        
        # Chart Type: normal or 3D
        query_params[:cht] = @options["is3D"] ? "p3" : "p"
        
        # Legend
        query_params[:chdl] = @data_table.get_column(0).join('|')
        
        # Labels
        query_params[:chl] = @data_table.get_column(0).join('|')
        
        # Data
        query_params[:chd] = "t:" + @data_table.get_column(1).join(',')
        
        # Chart Colors
        query_params[:chco] = @options["colors"].join('|').gsub(/#/, '') if @options["colors"]

        chart_image_url(query_params.merge(opts))
      end
    
    end

  end
end