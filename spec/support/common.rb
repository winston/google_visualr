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

def image_pie_chart(data_table=pie_data_table)
  GoogleVisualr::Image::PieChart.new( data_table, { :title => "Favorite Desserts", :width =>  500, :height => 200, :is3D => true } )
end

def image_pie_chart_uri
  URI.parse("https://chart.googleapis.com/chart?chdl=Pie%7CCake%7CIce+Cream%7CCookies&chs=500x200&cht=p3&chtt=Favorite+Desserts&chl=Pie%7CCake%7CIce+Cream%7CCookies&chd=t%3A100%2C120%2C150%2C80&chds=a")
end

def line_data_table
  data_table
end

def image_line_chart
  GoogleVisualr::Image::LineChart.new( data_table, { :title => "Test Line Chart", :width =>  500, :height => 200, :colors => ['#437E9D', '#E6A65A'] } )
end

def image_line_chart_uri
  URI.parse("https://chart.googleapis.com/chart?chxt=x%2Cy&chdl=Sales%7CExpenses&chs=500x200&chxl=0%3A%7C2004%7C2005%7C2006%7C2007&cht=lc&chtt=Test+Line+Chart&chco=437E9D%2CE6A65A&chd=t%3A1000%2C1200%2C1500%2C800%7C400%2C450%2C600%2C500&chds=a")
end

def bar_data_table
  data_table
end

def image_bar_chart
  GoogleVisualr::Image::BarChart.new( data_table, { :title => "Test Bar Chart", :width =>  500, :height => 200, :colors => ['#E6A65A', '#FFBF74'] } )
end

def image_bar_chart_uri
  URI.parse("https://chart.googleapis.com/chart?chxt=x%2Cy&chdl=Sales%7CExpenses&chs=500x200&chxl=0%3A%7C2004%7C2005%7C2006%7C2007&cht=bvg&chtt=Test+Bar+Chart&chco=E6A65A%2CFFBF74&chd=t%3A1000%2C1200%2C1500%2C800%7C400%2C450%2C600%2C500&chds=a")
end
