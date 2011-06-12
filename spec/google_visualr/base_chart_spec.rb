require 'spec_helper'

describe GoogleVisualr::BaseChart do

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
    @dt    = data_table
    @chart = GoogleVisualr::BaseChart.new( @dt, { :legend => "Test Chart", :width =>  800, :is3D => true } )
  end

  describe "#initialize" do
    it "works" do
      @chart.data_table.should == @dt
      @chart.options.should    == { "legend" => "Test Chart", "width" => 800, "is3D" => true }
    end
  end

  describe "#options=" do
    it "works" do
      @chart.options = { :legend => "Awesome Chart", :width =>  1000, :is3D => false }
      @chart.options.should    == { "legend" => "Awesome Chart", "width" => 1000, "is3D" => false }
    end
  end

  describe "#to_js" do
    it "generates JS" do
      js = @chart.to_js("#body")
      js.should_not be_nil
      js.should match /DataTable/i
      js.should match /addColumn/i
      js.should match /addRow/i
      js.should match /legend/i
      js.should match /Test Chart/i
      js.should match /width/i
      js.should match /800/i
    end
  end

end
