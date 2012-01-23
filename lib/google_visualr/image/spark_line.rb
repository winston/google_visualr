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
      #  *opts         [Optional] Hash of image line chart options
      def uri(opts = {})
        query_params = {}

        # Chart Type: sparkline
        query_params[:cht] = "ls"

        chart_image_url(query_params.merge(opts))
      end
    end
  end
end
