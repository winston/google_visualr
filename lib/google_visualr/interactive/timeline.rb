module GoogleVisualr
  module Interactive

    # https://developers.google.com/chart/interactive/docs/gallery/timeline
    class Timeline < BaseChart

      def initialize(data_table, options={})
        super
        @packages    = ['timeline']
        send(:options=, options)
      end

      # For Configuration Options, please refer to:
      # https://developers.google.com/chart/interactive/docs/gallery/timeline#Configuration_Options
    end

  end
end
