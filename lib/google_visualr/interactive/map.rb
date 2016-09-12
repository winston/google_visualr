module GoogleVisualr
  module Interactive

    # http://code.google.com/apis/chart/interactive/docs/gallery/map.html
    class Map < BaseChart

      def initialize(data_table, options={})
        super
        @packages    = ['map']
        send(:options=, options)
      end

      # For Configuration Options, please refer to:
      # http://code.google.com/apis/chart/interactive/docs/gallery/map.html#Configuration_Options
    end
    
  end
end
