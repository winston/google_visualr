module GoogleVisualr
  module Interactive

    # https://developers.google.com/chart/interactive/docs/gallery/calendar
    class Calendar < BaseChart

      def initialize(data_table, options={})
        super
        @packages    = ['calendar']
        send(:options=, options)
      end

      # For Configuration Options, please refer to:
      # https://developers.google.com/chart/interactive/docs/gallery/calendar#configuration-options
    end

  end
end
