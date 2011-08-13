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
      js = controller.render_chart "div_chart", base_chart
      js.should == base_chart_js("div_chart")
    end

  end

end
