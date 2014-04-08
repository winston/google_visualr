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

  describe "#chart_name" do
    it "returns class name (less module)" do
      @chart.chart_name.should == "BaseChart"
    end
  end

  describe "#chart_function_name" do
    it "returns a function name that is used to draw the chart in JS" do
      @chart.chart_function_name("base_chart").should == "draw_base_chart"
    end

    it "handles 'dashes' in element id" do
      @chart.chart_function_name("base-chart").should == "draw_base_chart"
    end
  end

  describe "#options=" do
    it "works" do
      @chart.options = { :legend => "Awesome Chart", :width =>  1000, :is3D => false }
      @chart.options.should    == { "legend" => "Awesome Chart", "width" => 1000, "is3D" => false }
    end
  end

  describe "#add_listener" do
    it "adds to listeners array" do
      @chart.add_listener("select", "function() {test_event(chart);}")
      @chart.listeners.should == [{ :event => "select", :callback => "function() {test_event(chart);}" }]
    end
  end

  describe "#to_js" do
    it "generates JS" do
      js = @chart.to_js("body")
      js.should == base_chart_js("body")
      js.should include("<script")
    end

    it "generates JS with listeners" do
      @chart.add_listener("select", "function() {test_event(chart);}")

      js = @chart.to_js("body")
      js.should == base_chart_with_listener_js("body")
    end
  end

end
