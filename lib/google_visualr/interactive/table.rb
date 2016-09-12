module GoogleVisualr
  module Interactive

    # http://code.google.com/apis/chart/interactive/docs/gallery/table.html
    class Table < BaseChart

      def initialize(data_table, options={})
        super
        @packages    = ['table']
        send(:options=, options)
      end

      # For Configuration Options, please refer to:
      # http://code.google.com/apis/chart/interactive/docs/gallery/table.html#Configuration_Options
    end

  end
end
