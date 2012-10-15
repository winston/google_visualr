def data_table

  @cols = [
            { :type => "string", :label => "Year"     },
            { :type => "number", :label => "Sales"    },
            { :type => "number", :label => "Expenses" }
          ]
  @rows = [
            { :c => [ {:v => "2004"}, {:v => 1000}, {:v => 400} ] },
            { :c => [ {:v => "2005"}, {:v => 1200}, {:v => 450} ] },
            { :c => [ {:v => "2006"}, {:v => 1500}, {:v => 600} ] },
            { :c => [ {:v => "2007"}, {:v => 800 }, {:v => 500} ] }
          ]
  GoogleVisualr::DataTable.new(:cols => @cols, :rows => @rows)

end

def base_chart(data_table=data_table)

  GoogleVisualr::BaseChart.new( data_table, { :legend => "Test Chart", :width =>  800, :is3D => true } )

end

def base_chart_js(div_class="div_class")

  js  = "\n<script type='text/javascript'>"
  js << "\n  google.load('visualization','1', {packages: ['basechart'], callback: function() {"
  js << "\n    var data_table = new google.visualization.DataTable();data_table.addColumn('string', 'Year');data_table.addColumn('number', 'Sales');data_table.addColumn('number', 'Expenses');data_table.addRow([{v: '2004'}, {v: 1000}, {v: 400}]);data_table.addRow([{v: '2005'}, {v: 1200}, {v: 450}]);data_table.addRow([{v: '2006'}, {v: 1500}, {v: 600}]);data_table.addRow([{v: '2007'}, {v: 800}, {v: 500}]);\n    var chart = new google.visualization.BaseChart(document.getElementById('#{div_class}'));"
  js << "\n    chart.draw(data_table, {legend: 'Test Chart', width: 800, is3D: true});"
  js << "\n  }});"
  js << "\n</script>"

end

def base_chart_listener_js(div_class="div_class")

  js  = "\n<script type='text/javascript'>"
  js << "\n  google.load('visualization','1', {packages: ['basechart'], callback: function() {"
  js << "\n    var data_table = new google.visualization.DataTable();data_table.addColumn('string', 'Year');data_table.addColumn('number', 'Sales');data_table.addColumn('number', 'Expenses');data_table.addRow([{v: '2004'}, {v: 1000}, {v: 400}]);data_table.addRow([{v: '2005'}, {v: 1200}, {v: 450}]);data_table.addRow([{v: '2006'}, {v: 1500}, {v: 600}]);data_table.addRow([{v: '2007'}, {v: 800}, {v: 500}]);\n    var chart = new google.visualization.BaseChart(document.getElementById('#{div_class}'));"
  js << "\n    chart.draw(data_table, {legend: 'Test Chart', width: 800, is3D: true});"
  js << "\n    google.visualization.events.addListener(chart, 'select', function() {test_event(chart);});"
  js << "\n  }});"
  js << "\n</script>"

end

# Helpers for image chart specs

def pie_data_table
  @cols = [
            { :type => "string", :label => "Favorite Dessert"     },
            { :type => "number", :label => "Count"    }
          ]
  @rows = [
            { :c => [ {:v => "Pie"}, {:v => 100} ] },
            { :c => [ {:v => "Cake"}, {:v => 120} ] },
            { :c => [ {:v => "Ice Cream"}, {:v => 150} ] },
            { :c => [ {:v => "Cookies"}, {:v => 80 } ] }
          ]
  GoogleVisualr::DataTable.new(:cols => @cols, :rows => @rows)
end

def image_pie_options
  [
    { :title => "Favorite Desserts", :is3D => false, :labels => "name", :backgroundColor => "#EFEFEF", :legend => "left" },
    { :title => "Favorite Desserts", :width =>  650, :height => 300, :is3D => true, :labels => "value", :backgroundColor => "#FFFFFF",
      :legend => "bottom" },
    { :title => "Favorite Desserts", :width =>  650, :height => 300, :is3D => false, :labels => "none", :backgroundColor => "#FFFFFF",
      :color => "#444D92", :legend => "top" },
    { :title => "Favorite Desserts", :width =>  650, :height => 300, :is3D => true, :labels => "none", :backgroundColor => "#FFFFFF",
      :colors => ['#444D92', '#4c56a2', '#5E67AB', '#7078B5', '#8289BE', '#949AC7',
        '#A6AAD0', '#B7BBDA', '#C9CCE3', '#DBDDEC', '#EDEEF6'], :legend => "none" }
  ]
end

def image_pie_chart_uris
  [
    URI.parse("https://chart.googleapis.com/chart?chxt=x%2Cy&chf=bg%2Cs%2CEFEFEF&chdl=2004%7C2005%7C2006%7C2007&chs=400x200&cht=p&chdlp=l&chtt=Favorite+Desserts&chl=2004%7C2005%7C2006%7C2007&chd=t%3A1000%2C1200%2C1500%2C800&chds=a"),
    URI.parse("https://chart.googleapis.com/chart?chxt=x%2Cy&chf=bg%2Cs%2CFFFFFF&chdl=2004%7C2005%7C2006%7C2007&chs=650x300&cht=p3&chdlp=b&chtt=Favorite+Desserts&chl=1000%7C1200%7C1500%7C800&chd=t%3A1000%2C1200%2C1500%2C800&chds=a"),
    URI.parse("https://chart.googleapis.com/chart?chxt=x%2Cy&chf=bg%2Cs%2CFFFFFF&chdl=2004%7C2005%7C2006%7C2007&chs=650x300&cht=p&chdlp=t&chtt=Favorite+Desserts&chco=444D92&chl=&chd=t%3A1000%2C1200%2C1500%2C800&chds=a"),
    URI.parse("https://chart.googleapis.com/chart?chxt=x%2Cy&chf=bg%2Cs%2CFFFFFF&chdl=2004%7C2005%7C2006%7C2007&chs=650x300&cht=p3&chtt=Favorite+Desserts&chco=444D92%7C4c56a2%7C5E67AB%7C7078B5%7C8289BE%7C949AC7%7CA6AAD0%7CB7BBDA%7CC9CCE3%7CDBDDEC%7CEDEEF6&chl=&chd=t%3A1000%2C1200%2C1500%2C800&chds=a")
  ]
end

def image_line_options
  [
    { :title => "Test1 Line Chart", :colors => ['#437E9D', '#E6A65A'], :legend => "left", 
      :backgroundColor => "#EFEFEF", :showCategoryLabels => true, :showValueLabels => false },
    { :title => "Test2 Line Chart", :width =>  500, :height => 200, :color => '#437E9D', :legend => "right", 
      :backgroundColor => "#FFFFFF", :showCategoryLabels => false, :showValueLabels => true },
    { :title => "Test3 Line Chart", :width =>  500, :height => 200, :colors => ['#437E9D', '#E6A65A'], :legend => "top", 
      :showCategoryLabels => false, :showValueLabels => false, :showAxisLines => false },
    { :title => "Test4 Line Chart", :width =>  500, :height => 200, :color => '#437E9D', :legend => "bottom", 
      :showCategoryLabels => true, :showValueLabels => true, :showAxisLines => true },
    { :title => "Test5 Line Chart", :width =>  500, :height => 200, :color => '#437E9D', :legend => "none", 
      :showCategoryLabels => true, :showValueLabels => true, :min => 200, :max => 2000, :valueLabelsInterval => 200 }
  ]
end

def image_line_chart_uris
  [
    URI.parse("https://chart.googleapis.com/chart?chxt=x%2Cy&chf=bg%2Cs%2CEFEFEF&chdl=Sales%7CExpenses&chs=400x200&chxl=0%3A%7C2004%7C2005%7C2006%7C2007%7C1%3A%7C%7C&cht=lc&chdlp=l&chtt=Test1+Line+Chart&chco=437E9D%2CE6A65A&chd=t%3A1000%2C1200%2C1500%2C800%7C400%2C450%2C600%2C500&chds=a"),
    URI.parse("https://chart.googleapis.com/chart?chxt=x%2Cy&chf=bg%2Cs%2CFFFFFF&chdl=Sales%7CExpenses&chs=500x200&chxl=0%3A%7C%7C&cht=lc&chdlp=r&chtt=Test2+Line+Chart&chco=437E9D&chds=a&chd=t%3A1000%2C1200%2C1500%2C800%7C400%2C450%2C600%2C500"),
    URI.parse("https://chart.googleapis.com/chart?chxt=x%2Cy&chdl=Sales%7CExpenses&chs=500x200&chxl=0%3A%7C%7C1%3A%7C%7C&cht=lc%3Anda&chdlp=t&chtt=Test3+Line+Chart&chco=437E9D%2CE6A65A&chds=a&chd=t%3A1000%2C1200%2C1500%2C800%7C400%2C450%2C600%2C500"),
    URI.parse("https://chart.googleapis.com/chart?chxt=x%2Cy&chdl=Sales%7CExpenses&chs=500x200&chxl=0%3A%7C2004%7C2005%7C2006%7C2007%7C&cht=lc&chdlp=b&chtt=Test4+Line+Chart&chco=437E9D&chd=t%3A1000%2C1200%2C1500%2C800%7C400%2C450%2C600%2C500&chds=a"),
    URI.parse("https://chart.googleapis.com/chart?chxt=x%2Cy&chs=500x200&chxl=0%3A%7C2004%7C2005%7C2006%7C2007%7C&cht=lc&chtt=Test5+Line+Chart&chco=437E9D&chd=t%3A1000%2C1200%2C1500%2C800%7C400%2C450%2C600%2C500&chxr=1%2C200%2C2000%2C200&chds=200%2C2000")
  ]
end

def image_bar_options
  [
    { :title => "Test1 Bar Chart", :colors => ['#437E9D', '#E6A65A'], :legend => "left", 
      :backgroundColor => "#EFEFEF", :showCategoryLabels => true, :showValueLabels => false },
    { :title => "Test2 Bar Chart", :width =>  500, :height => 200, :color => '#437E9D', :legend => "right", 
      :backgroundColor => "#FFFFFF", :showCategoryLabels => false, :showValueLabels => true },
    { :title => "Test3 Bar Chart", :width =>  500, :height => 200, :colors => ['#437E9D', '#E6A65A'], :legend => "top", 
      :showCategoryLabels => false, :showValueLabels => false },
    { :title => "Test4 Bar Chart", :width =>  500, :height => 200, :colors => ['#437E9D', '#E6A65A'], :legend => "bottom", 
      :showCategoryLabels => true, :showValueLabels => true, :isStacked => false, :isVertical => true },
    { :title => "Test5 Bar Chart", :width =>  500, :height => 200, :colors => ['#437E9D', '#E6A65A'], :legend => "none", 
      :isStacked => true, :isVertical => true, :min => 200, :max => 2000, :valueLabelsInterval => 200 }
  ]
end

def image_bar_chart_uris
  [
    URI.parse("https://chart.googleapis.com/chart?chxt=x%2Cy&chf=bg%2Cs%2CEFEFEF&chdl=Sales%7CExpenses&chs=400x200&chxl=1%3A%7C2004%7C2005%7C2006%7C2007%7C0%3A%7C%7C&cht=bhs&chdlp=l&chtt=Test1+Bar+Chart&chco=437E9D%2CE6A65A&chd=t%3A1000%2C1200%2C1500%2C800%7C400%2C450%2C600%2C500&chds=a"),
    URI.parse("https://chart.googleapis.com/chart?chxt=x%2Cy&chf=bg%2Cs%2CFFFFFF&chdl=Sales%7CExpenses&chs=500x200&chxl=1%3A%7C%7C&cht=bhs&chdlp=r&chtt=Test2+Bar+Chart&chco=437E9D&chds=a&chd=t%3A1000%2C1200%2C1500%2C800%7C400%2C450%2C600%2C500"),
    URI.parse("https://chart.googleapis.com/chart?chxt=x%2Cy&chdl=Sales%7CExpenses&chs=500x200&chxl=1%3A%7C%7C0%3A%7C%7C&cht=bhs&chdlp=t&chtt=Test3+Bar+Chart&chco=437E9D%2CE6A65A&chds=a&chd=t%3A1000%2C1200%2C1500%2C800%7C400%2C450%2C600%2C500"),
    URI.parse("https://chart.googleapis.com/chart?chxt=x%2Cy&chdl=Sales%7CExpenses&chs=500x200&chxl=0%3A%7C2004%7C2005%7C2006%7C2007%7C&cht=bvg&chdlp=b&chtt=Test4+Bar+Chart&chco=437E9D%2CE6A65A&chd=t%3A1000%2C1200%2C1500%2C800%7C400%2C450%2C600%2C500&chds=a"),
    URI.parse("https://chart.googleapis.com/chart?chxt=x%2Cy&chs=500x200&chxl=0%3A%7C2004%7C2005%7C2006%7C2007%7C&cht=bvs&chtt=Test5+Bar+Chart&chco=437E9D%2CE6A65A&chd=t%3A1000%2C1200%2C1500%2C800%7C400%2C450%2C600%2C500&chxr=1%2C200%2C2000%2C200&chds=200%2C2000")
  ]
end

def sparkline_options
  [
    { :title => "Test1 Sparkline", :colors => ['#437E9D', '#E6A65A'], :legend => "left", 
      :backgroundColor => "#EFEFEF", :showAxisLines => false },
    { :title => "Test2 Sparkline", :width =>  500, :height => 200, :color => '#437E9D', :legend => "right", 
      :backgroundColor => "#FFFFFF", :showAxisLines => true },
    { :title => "Test3 Sparkline", :width =>  500, :height => 200, :colors => ['#437E9D', '#E6A65A'], :legend => "top", 
      :showAxisLines => false },
    { :title => "Test4 Sparkline", :width =>  500, :height => 200, :color => '#437E9D', :legend => "bottom", 
      :showAxisLines => false },
    { :title => "Test5 Sparkline", :width =>  500, :height => 200, :colors => ['#437E9D', '#E6A65A'], :legend => "none", 
      :showAxisLines => false }
  ]
end

def sparkline_uris
  [
    URI.parse("https://chart.googleapis.com/chart?chxt=x%2Cy&chf=bg%2Cs%2CEFEFEF&chdl=Sales%7CExpenses&chs=400x200&chxl=0%3A%7C%7C1%3A%7C%7C&cht=ls&chdlp=l&chtt=Test1+Sparkline&chco=437E9D%2CE6A65A&chd=t%3A1000%2C1200%2C1500%2C800%7C400%2C450%2C600%2C500&chds=a"),
    URI.parse("https://chart.googleapis.com/chart?chxt=x%2Cy&chf=bg%2Cs%2CFFFFFF&chdl=Sales%7CExpenses&chs=500x200&chxl=0%3A%7C%7C&cht=ls&chdlp=r&chtt=Test2+Sparkline&chco=437E9D&chd=t%3A1000%2C1200%2C1500%2C800%7C400%2C450%2C600%2C500&chds=a"),
    URI.parse("https://chart.googleapis.com/chart?chxt=x%2Cy&chdl=Sales%7CExpenses&chs=500x200&chxl=0%3A%7C%7C1%3A%7C%7C&cht=ls&chdlp=t&chtt=Test3+Sparkline&chco=437E9D%2CE6A65A&chd=t%3A1000%2C1200%2C1500%2C800%7C400%2C450%2C600%2C500&chds=a"),
    URI.parse("https://chart.googleapis.com/chart?chxt=x%2Cy&chdl=Sales%7CExpenses&chs=500x200&chxl=0%3A%7C%7C1%3A%7C%7C&cht=ls&chdlp=b&chtt=Test4+Sparkline&chco=437E9D&chd=t%3A1000%2C1200%2C1500%2C800%7C400%2C450%2C600%2C500&chds=a"),
    URI.parse("https://chart.googleapis.com/chart?chxt=x%2Cy&chs=500x200&chxl=0%3A%7C%7C1%3A%7C%7C&cht=ls&chtt=Test5+Sparkline&chco=437E9D%2CE6A65A&chd=t%3A1000%2C1200%2C1500%2C800%7C400%2C450%2C600%2C500&chds=a")
  ]
end