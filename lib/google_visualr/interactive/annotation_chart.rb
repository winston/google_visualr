module GoogleVisualr
  module Interactive

    # https://developers.google.com/chart/interactive/docs/gallery/annotationchart
    class AnnotationChart < BaseChart

      def initialize(data_table, options={})
        super
        @packages    = ['annotationchart']
        send(:options=, options)
      end

      # For Configuration Options, please refer to:
      # https://developers.google.com/chart/interactive/docs/gallery/annotationchart#configuration-options
    end

  end
end
