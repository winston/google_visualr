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
      #  *opts         [Optional] Hash of image line chart options
      def uri(opts = {})
        query_params = {}
        
        # Chart type: line
        query_params[:cht] = "lc"
        
        # showAxisLines
        if @options["showAxisLines"].present? && @options["showAxisLines"] == false
          query_params[:cht] = "lc:nda"
        end

        chart_image_url(query_params.merge(opts))
      end
    end

  end
end