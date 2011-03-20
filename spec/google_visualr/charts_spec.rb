require 'spec_helper'

describe 'ChartsSpec' do

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


  before do
    @dt = data_table
  end

  describe 'GoogleVisualr::Visualizations::AreaChart' do
    let (:chart) { GoogleVisualr::Visualizations::AreaChart.new(@dt, {:legend => "Test Chart", :width => 800}) }

    it "initializes" do
      chart.should_not be_nil
    end

    it "generates JS" do
      chart.to_js("#body").should_not be_nil
    end
  end

end