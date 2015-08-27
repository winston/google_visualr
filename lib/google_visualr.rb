lib_path = File.dirname(__FILE__)

# Common
require "#{lib_path}/google_visualr/param_helpers"

# Base Classes
require "#{lib_path}/google_visualr/data_table"

require "#{lib_path}/google_visualr/packages"
require "#{lib_path}/google_visualr/base_chart"

require "#{lib_path}/google_visualr/formatters"

# Interactive Charts

## Main
require "#{lib_path}/google_visualr/interactive/annotated_time_line"
require "#{lib_path}/google_visualr/interactive/annotation_chart"
require "#{lib_path}/google_visualr/interactive/area_chart"
require "#{lib_path}/google_visualr/interactive/bar_chart"
require "#{lib_path}/google_visualr/interactive/bubble_chart"
require "#{lib_path}/google_visualr/interactive/calendar"
require "#{lib_path}/google_visualr/interactive/candlestick_chart"
require "#{lib_path}/google_visualr/interactive/column_chart"
require "#{lib_path}/google_visualr/interactive/combo_chart"
require "#{lib_path}/google_visualr/interactive/gantt_chart"
require "#{lib_path}/google_visualr/interactive/gauge"
require "#{lib_path}/google_visualr/interactive/geo_chart"
require "#{lib_path}/google_visualr/interactive/geo_map"
require "#{lib_path}/google_visualr/interactive/histogram"
require "#{lib_path}/google_visualr/interactive/intensity_map"
require "#{lib_path}/google_visualr/interactive/line_chart"
require "#{lib_path}/google_visualr/interactive/map"
require "#{lib_path}/google_visualr/interactive/motion_chart"
require "#{lib_path}/google_visualr/interactive/org_chart"
require "#{lib_path}/google_visualr/interactive/pie_chart"
require "#{lib_path}/google_visualr/interactive/sankey"
require "#{lib_path}/google_visualr/interactive/scatter_chart"
require "#{lib_path}/google_visualr/interactive/stepped_area_chart"
require "#{lib_path}/google_visualr/interactive/table"
require "#{lib_path}/google_visualr/interactive/timeline"
require "#{lib_path}/google_visualr/interactive/tree_map"
require "#{lib_path}/google_visualr/interactive/word_tree"

# Image Charts
require "#{lib_path}/google_visualr/image/spark_line"
require "#{lib_path}/google_visualr/image/bar_chart"
require "#{lib_path}/google_visualr/image/line_chart"
require "#{lib_path}/google_visualr/image/pie_chart"


# Rails Helper
require "#{lib_path}/google_visualr/app/railtie.rb" if defined?(Rails)
