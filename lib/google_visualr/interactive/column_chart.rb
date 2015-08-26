module GoogleVisualr
  module Interactive

    # http://code.google.com/apis/chart/interactive/docs/gallery/columnchart.html
    class ColumnChart < BaseChart
      include GoogleVisualr::Packages::CoreChart

      def package_name
        if material
          "bar"
        else
          super
        end
      end

      def chart_name
        if material
          "Bar"
        else
          super
        end
      end

      # For Configuration Options, please refer to:
      # http://code.google.com/apis/chart/interactive/docs/gallery/columnchart.html#Configuration_Options
    end

  end
end
