module GoogleVisualr
  module Interactive

    # https://developers.google.com/chart/interactive/docs/gallery/ganttchart
    class Gantt < BaseChart

      def initialize(data_table, options={})
        super
        @packages    = ['gantt']
        send(:options=, options)
      end

      def package_name
        "gantt"
      end

      # For Configuration Options, please refer to:
      # https://developers.google.com/chart/interactive/docs/gallery/ganttchart#configuration-options
    end

  end
end
