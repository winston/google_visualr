def data_table
  @cols = [
    { :type => "string", :label => "Year" },
    { :type => "number", :label => "Sales" },
    { :type => "number", :label => "Expenses" }
  ]
  @rows = [
    { :c => [{ :v => "2004" }, { :v => 1000 }, { :v => 400 }] },
    { :c => [{ :v => "2005" }, { :v => 1200 }, { :v => 450 }] },
    { :c => [{ :v => "2006" }, { :v => 1500 }, { :v => 600 }] },
    { :c => [{ :v => "2007" }, { :v => 800  }, { :v => 500 }] }
  ]
  GoogleVisualr::DataTable.new(:cols => @cols, :rows => @rows)
end

def base_chart(data_table = data_table())
  GoogleVisualr::BaseChart.new(data_table, { :legend => "Test Chart", :width => 800, :is3D => true })
end

def base_chart_js_without_script_tag(div_class = "div_class", language = nil)
  language_opt = ", language: '#{language}'" if language

  js =  "\n  google.load('visualization', '1.0', {packages: ['basechart']#{language_opt}, callback: draw_#{div_class}});"
  js << "\n  function draw_#{div_class}() {"
  js << "\n    var data_table = new google.visualization.DataTable();data_table.addColumn({\"type\":\"string\",\"label\":\"Year\"});data_table.addColumn({\"type\":\"number\",\"label\":\"Sales\"});data_table.addColumn({\"type\":\"number\",\"label\":\"Expenses\"});data_table.addRow([{v: \"2004\"}, {v: 1000}, {v: 400}]);data_table.addRow([{v: \"2005\"}, {v: 1200}, {v: 450}]);data_table.addRow([{v: \"2006\"}, {v: 1500}, {v: 600}]);data_table.addRow([{v: \"2007\"}, {v: 800}, {v: 500}]);\n    var chart = new google.visualization.BaseChart(document.getElementById('#{div_class}'));"
  js << "\n    chart.draw(data_table, {legend: \"Test Chart\", width: 800, is3D: true});"
  js << "\n  };"
end

def base_chart_js(div_class = "div_class", language = nil)
  js =  "\n<script type='text/javascript'>"
  js << base_chart_js_without_script_tag(div_class, language)
  js << "\n</script>"
end

def base_chart_with_listener_js(div_class = "div_class")
  js =  "\n<script type='text/javascript'>"
  js << "\n  google.load('visualization', '1.0', {packages: ['basechart'], callback: draw_#{div_class}});"
  js << "\n  function draw_#{div_class}() {"
  js << "\n    var data_table = new google.visualization.DataTable();data_table.addColumn({\"type\":\"string\",\"label\":\"Year\"});data_table.addColumn({\"type\":\"number\",\"label\":\"Sales\"});data_table.addColumn({\"type\":\"number\",\"label\":\"Expenses\"});data_table.addRow([{v: \"2004\"}, {v: 1000}, {v: 400}]);data_table.addRow([{v: \"2005\"}, {v: 1200}, {v: 450}]);data_table.addRow([{v: \"2006\"}, {v: 1500}, {v: 600}]);data_table.addRow([{v: \"2007\"}, {v: 800}, {v: 500}]);\n    var chart = new google.visualization.BaseChart(document.getElementById('#{div_class}'));"
  js << "\n    google.visualization.events.addListener(chart, 'select', function() {test_event(chart);});"
  js << "\n    chart.draw(data_table, {legend: \"Test Chart\", width: 800, is3D: true});"
  js << "\n  };"
  js << "\n</script>"
end

def material_chart(div_class = "div_class")
  js =  "\n<script type='text/javascript'>"
  js << "\n  google.load('visualization', '1.0', {packages: ['basechart'], callback: draw_#{div_class}});"
  js << "\n  function draw_#{div_class}() {"
  js << "\n    var data_table = new google.visualization.DataTable();data_table.addColumn({\"type\":\"string\",\"label\":\"Year\"});data_table.addColumn({\"type\":\"number\",\"label\":\"Sales\"});data_table.addColumn({\"type\":\"number\",\"label\":\"Expenses\"});data_table.addRow([{v: \"2004\"}, {v: 1000}, {v: 400}]);data_table.addRow([{v: \"2005\"}, {v: 1200}, {v: 450}]);data_table.addRow([{v: \"2006\"}, {v: 1500}, {v: 600}]);data_table.addRow([{v: \"2007\"}, {v: 800}, {v: 500}]);\n    var chart = new google.charts.Base(document.getElementById('#{div_class}'));"
  js << "\n    chart.draw(data_table, {legend: \"Test Chart\", width: 800, is3D: true});"
  js << "\n  };"
  js << "\n</script>"
end
