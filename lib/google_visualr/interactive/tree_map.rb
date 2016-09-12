module GoogleVisualr
  module Interactive

    # http://code.google.com/apis/chart/interactive/docs/gallery/treemap.html
    class TreeMap < BaseChart

      def initialize(data_table, options={})
        super
        @packages    = ['treemap']
        send(:options=, options)
      end

      # For Configuration Options, please refer to:
      # http://code.google.com/apis/chart/interactive/docs/gallery/treemap.html#Configuration_Options
    end

  end
end
