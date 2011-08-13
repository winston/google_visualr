require 'spec_helper'

describe ApplicationController do

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

  def expected
    js  = "\n<script type='text/javascript'>"
    js << "\n  google.load('visualization','1', {packages: ['basechart'], callback: function() {"
    js << "\n    var data_table = new google.visualization.DataTable();data_table.addColumn('string', 'Year');data_table.addColumn('number', 'Sales');data_table.addColumn('number', 'Expenses');data_table.addRow([{v: '2004'}, {v: 1000}, {v: 400}]);data_table.addRow([{v: '2005'}, {v: 1200}, {v: 450}]);data_table.addRow([{v: '2006'}, {v: 1500}, {v: 600}]);data_table.addRow([{v: '2007'}, {v: 800}, {v: 500}]);\n    var chart = new google.visualization.BaseChart(document.getElementById('div_class'));"
    js << "\n    chart.draw(data_table, {legend: 'Test Chart', width: 800, is3D: true});"
    js << "\n  }});"
    js << "\n</script>"
  end

  describe "#render_chart" do
    it "has method" do
      ApplicationController.instance_methods.should include :render_chart
    end

    it "includes method in corresponding helper" do
      ApplicationController.helpers.methods.should  include :render_chart
    end

    it "returns html_safe javascript" do
      @dt    = data_table
      @chart = GoogleVisualr::BaseChart.new( @dt, { :legend => "Test Chart", :width =>  800, :is3D => true } )

      controller = ApplicationController.new
      js = controller.render_chart "div_class", @chart
      js.should == expected
    end
  end
end