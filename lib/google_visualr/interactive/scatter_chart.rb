module GoogleVisualr
  module Interactive

    # http://code.google.com/apis/chart/interactive/docs/gallery/scatterchart.html
    class ScatterChart < BaseChart
      include GoogleVisualr::Packages::CoreChart

      def package_name
        if material
          "scatter"
        else
          super
        end
      end

      # For Configuration Options, please refer to:
      # http://code.google.com/apis/chart/interactive/docs/gallery/scatterchart.html#Configuration_Options
    end

  end
end
