module GoogleVisualr
  module Interactive

    # http://code.google.com/apis/chart/interactive/docs/gallery/linechart.html
    class LineChart < BaseChart
      include GoogleVisualr::Packages::CoreChart

      def package_name
        if material
          "line"
        else
          super
        end
      end

      # For Configuration Options, please refer to:
      # http://code.google.com/apis/chart/interactive/docs/gallery/linechart.html#Configuration_Options
    end

  end
end
