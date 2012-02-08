module GoogleVisualr
  module Image

    # http://code.google.com/apis/chart/interactive/docs/gallery/imagelinechart.html
    class LineChart < BaseChart
      include GoogleVisualr::Packages::ImageChart

      # For Configuration Options, please refer to:
      # http://code.google.com/apis/chart/interactive/docs/gallery/imagelinechart.html

      # Create URI for image line chart. Override parameters by passing in a hash.
      # (see http://code.google.com/apis/chart/image/docs/chart_params.html)
      #
      # Parameters:
      #  *params         [Optional] Hash of url query parameters
      def uri(params = {})
        query_params = {}
        
        # Chart type: line
        query_params[:cht] = "lc"
        
        # showAxisLines
        if @options["showAxisLines"] == false
          query_params[:cht] = "lc:nda"
        end

        # showCategoryLabels (works as long as :chxt => "x,y")
        labels = ""
        if @options["showCategoryLabels"] == false
          labels = "0:||"
        else
          labels = "0:|" + data_table.get_column(0).join('|') + "|"
        end
        
        # showValueLabels  (works as long as :chxt => "x,y")
        if @options["showValueLabels"] == false
          labels += "1:||"
        end
        
        query_params[:chxl] = labels unless labels.blank?

        chart_image_url(query_params.merge(params))
      end
    end

  end
end