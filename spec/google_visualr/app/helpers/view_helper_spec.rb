require 'spec_helper'

describe "ApplicationController" do
  describe "#render_chart" do
    it "has method" do
      ApplicationController.instance_methods.should include :render_chart
    end

    it "includes method in corresponding helper" do
      ApplicationController.helpers.methods.should  include :render_chart
    end

    it "returns html_safe javascript" do
      controller = ApplicationController.new
      js = controller.render_chart base_chart, "div_chart"
      js.should == base_chart_js("div_chart")
    end

    it "returns html_safe javascript without script tag" do
      controller = ApplicationController.new
      js = controller.render_chart base_chart, "div_chart", script_tag: false
      js.should == base_chart_js_without_script_tag("div_chart")
    end
  end
end
