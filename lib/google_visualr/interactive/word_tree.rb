module GoogleVisualr
  module Interactive

    # https://developers.google.com/chart/interactive/docs/gallery/wordtree
    class WordTree < BaseChart

      def initialize(data_table, options={})
        super
        @packages    = ['wordtree']
        send(:options=, options)
      end

      # For Configuration Options, please refer to:
      # https://developers.google.com/chart/interactive/docs/gallery/wordtree#a-simple-example
    end

  end
end
