module GoogleVisualr
  module Image

    # http://code.google.com/apis/chart/interactive/docs/gallery/imagebarchart.html
    class BarChart < BaseChart
      include GoogleVisualr::Packages::ImageChart

      # For Configuration Options, please refer to:
      # http://code.google.com/apis/chart/interactive/docs/gallery/imagebarchart.html

      # Create URI for image bar chart.  Override parameters by passing in a hash.
      # (see http://code.google.com/apis/chart/image/docs/chart_params.html)
      #
      # Parameters:
      #  *opts         [Optional] Hash of image bar chart options
      def uri(opts = {})
        query_params = {}
        
        # isStacked/isVertical, Chart Type
        chart_type = "b"
        chart_type += @options["isVertical"] ? "v" : "h"
        chart_type += @options["isStacked"] ? "s" : "g"
        query_params[:cht] = chart_type

        # showCategoryLabels (works as long as :chxt => "x,y")
        labels = ""
        val_column = @options["isVertical"] ? 1 : 0
        cat_column = @options["isVertical"] ? 0 : 1
        unless @options["showCategoryLabels"].present? && @options["showCategoryLabels"] == false
          labels = "#{cat_column}:|" + @data_table.get_column(0).join('|') + "|"
        end
        # showValueLabels  (works as long as :chxt => "x,y")
        if @options["showValueLabels"].present? && @options["showValueLabels"] == false
          labels += "#{val_column}:||"
        end
        query_params[:chxl] = labels unless labels.blank?
        
        chart_image_url(query_params.merge(opts))
      end
    end

  end
end
