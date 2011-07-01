lib_path = File.dirname(__FILE__)

# Common
require "#{lib_path}/google_visualr/param_helpers"

require "#{lib_path}/google_visualr/data_table"

require "#{lib_path}/google_visualr/packages"
require "#{lib_path}/google_visualr/base_chart"

require "#{lib_path}/google_visualr/formatters"

# Interactive Charts (Previously known as Visualizations)

## Main
require "#{lib_path}/google_visualr/interactive/area_chart"
require "#{lib_path}/google_visualr/interactive/bar_chart"
require "#{lib_path}/google_visualr/interactive/column_chart"
require "#{lib_path}/google_visualr/interactive/gauge"
require "#{lib_path}/google_visualr/interactive/geo_chart"
require "#{lib_path}/google_visualr/interactive/line_chart"
require "#{lib_path}/google_visualr/interactive/pie_chart"
require "#{lib_path}/google_visualr/interactive/scatter_chart"
require "#{lib_path}/google_visualr/interactive/table"

## Additional
require "#{lib_path}/google_visualr/interactive/annotated_time_line"
require "#{lib_path}/google_visualr/interactive/intensity_map"
require "#{lib_path}/google_visualr/interactive/map"
require "#{lib_path}/google_visualr/interactive/motion_chart"
require "#{lib_path}/google_visualr/interactive/org_chart"

# Image Charts
require "#{lib_path}/google_visualr/image/spark_line"

