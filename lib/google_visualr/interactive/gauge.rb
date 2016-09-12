module GoogleVisualr
  module Interactive

    # http://code.google.com/apis/chart/interactive/docs/gallery/gauge.html
    class Gauge < BaseChart

      def initialize(data_table, options={})
        super
        @packages    = ['gauge']
        send(:options=, options)
      end

      # For Configuration Options, please refer to:
      # http://code.google.com/apis/chart/interactive/docs/gallery/gauge.html#Configuration_Options
    end

  end
end
