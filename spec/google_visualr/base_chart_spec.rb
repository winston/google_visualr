require 'spec_helper'

describe GoogleVisualr::BaseChart do

  before do
    @dt    = data_table
    @chart = base_chart(@dt)
  end

  describe "#initialize" do
    it "works" do
      @chart.data_table.should == @dt
      @chart.version.should    == GoogleVisualr::BaseChart::DEFAULT_VERSION
      @chart.material.should   == false
      @chart.options.should    == { "legend" => "Test Chart", "width" => 800, "is3D" => true }
      @chart.language.should   == nil
    end

    it "accepts version attribute" do
      @chart = GoogleVisualr::BaseChart.new(@dt, version: "1.1")
      @chart.version.should    == "1.1"
    end

    it "accepts language attribute" do
      @chart = GoogleVisualr::BaseChart.new(@dt, language: "ja")
      @chart.language.should    == "ja"
    end

    it "accepts material attribute" do
      @chart = GoogleVisualr::BaseChart.new(@dt, material: true)
      @chart.material.should   == true
    end
  end

  describe "#package_name" do
    it "returns class name (without module) and downcased" do
      @chart.package_name.should == "basechart"
    end
  end

  describe "#class_name" do
    it "returns class name (without module)" do
      @chart.class_name.should == "BaseChart"
    end
  end

  describe "#chart_class" do
    it "returns 'charts' when material is true" do
      @chart.material = true
      @chart.chart_class.should == "charts"
    end

    it "returns 'charts' when material is false" do
      @chart.material = false
      @chart.chart_class.should == "visualization"
    end
  end

  describe "#chart_name" do
    it "returns class name (less module) when material is true" do
      @chart.material = true
      @chart.chart_name.should == "Base"
    end

    it "returns class name (less module) when material is false" do
      @chart.material = false
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

    it "generates JS without any locale as default" do
      js = @chart.to_js("body")
      js.should == base_chart_js("body", nil)
    end

    it "generates JS of a different locale" do
      @chart.language = "ja"

      js = @chart.to_js("body")
      js.should == base_chart_js("body", "ja")
    end

    it "generates JS with listeners" do
      @chart.add_listener("select", "function() {test_event(chart);}")

      js = @chart.to_js("body")
      js.should == base_chart_with_listener_js("body")
    end

    it "generates JS for material charts" do
      @chart.material = true

      js = @chart.to_js("body")
      js.should == material_chart("body")
    end
  end

end
