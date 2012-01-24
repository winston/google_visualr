module GoogleVisualr
  module Image

    # http://code.google.com/apis/chart/interactive/docs/gallery/imagesparkline.html
    class SparkLine < BaseChart
      include GoogleVisualr::Packages::ImageChart

      # For Configuration Options, please refer to:
      # http://code.google.com/apis/chart/interactive/docs/gallery/imagesparkline.html

      # Create URI for sparkline. Override parameters by passing in a hash.
      # (see http://code.google.com/apis/chart/image/docs/chart_params.html)
      #
      # Parameters:
      #  *params         [Optional] Hash of url query parameters
      def uri(params = {})
        query_params = {}
        
        # Chart type: line
        query_params[:cht] = "ls"
        
        # showValueLabels  (works as long as :chxt => "x,y")
        labels = "0:||"
        if @options["showValueLabels"] == false || !@options["showAxisLines"]
          labels += "1:||"
        end
        
        query_params[:chxl] = labels

        chart_image_url(query_params.merge(params))
      end
    end
  end
end
