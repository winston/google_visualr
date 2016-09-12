module GoogleVisualr
  module Interactive

    # http://code.google.com/apis/chart/interactive/docs/gallery/orgchart.html
    class OrgChart < BaseChart

      def initialize(data_table, options={})
        super
        @packages    = ['orgchart']
        send(:options=, options)
      end

      # For Configuration Options, please refer to:
      # http://code.google.com/apis/chart/interactive/docs/gallery/orgchart.html#Configuration_Options
    end

  end
end
