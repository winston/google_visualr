module GoogleVisualr
  module Image

    # http://code.google.com/apis/chart/interactive/docs/gallery/imagepiechart.html
    class PieChart < BaseChart
      include GoogleVisualr::Packages::ImageChart

      # For Configuration Options, please refer to:
      # http://code.google.com/apis/chart/interactive/docs/gallery/imagepiechart.html
      
      # Create URI for image pie chart.  Override parameters by passing in a hash.
      # (see http://code.google.com/apis/chart/image/docs/chart_params.html)
      #
      # Parameters:
      #  *params         [Optional] Hash of url query parameters
      def uri(params = {})
        query_params = {}
        
        # Chart Type: normal or 3D
        query_params[:cht] = @options["is3D"] ? "p3" : "p"
        
        # Legend (override generic image chart behavior)
        query_params[:chdl] = @data_table.get_column(0).join('|')
        
        # Labels
        case options["labels"]
        when "name"
          query_params[:chl] = @data_table.get_column(0).join('|')
        when "value"
          query_params[:chl] = @data_table.get_column(1).join('|')
        else
          query_params[:chl] = ""
        end
        
        # data (override generic chart behavior)
        query_params[:chd] = "t:" + @data_table.get_column(1).join(',')
        
        # Chart Colors (override generic chart default)
        query_params[:chco] = @options["colors"].join('|').gsub(/#/, '') if @options["colors"]

        chart_image_url(query_params.merge(params))
      end
    
    end

  end
end