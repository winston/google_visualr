require 'spec_helper'

describe GoogleVisualr::BaseChart do

  before do
    @dt    = data_table
    @chart = base_chart(@dt)
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
      js = @chart.to_js("body")
      js.should == base_chart_js("body")
    end
  end

  describe "listener" do
    it "added to JS" do
      @chart.add_listener("select", "function() {test_event(chart);}")
      js = @chart.to_js("body")
      js.should == base_chart_listener_js("body")
    end
  end

end
