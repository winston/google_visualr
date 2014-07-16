module GoogleVisualr
  module Interactive

    # http://code.google.com/apis/chart/interactive/docs/gallery/columnchart.html
    class HistogramChart < BaseChart
      include GoogleVisualr::Packages::CoreChart

      def chart_name
        'Histogram'
      end

      # For Configuration Options, please refer to:
      # https://developers.google.com/chart/interactive/docs/gallery/histogram#Configuration_Options
    end

  end
end

