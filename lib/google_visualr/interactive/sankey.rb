module GoogleVisualr
  module Interactive

    # https://developers.google.com/chart/interactive/docs/gallery/sankey
    class Sankey < BaseChart

      def initialize(data_table, options={})
        super
        @packages    = ['sankey']
        send(:options=, options)
      end

      # For Configuration Options, please refer to:
      # https://developers.google.com/chart/interactive/docs/gallery/sankey#configuration-options
    end

  end
end
