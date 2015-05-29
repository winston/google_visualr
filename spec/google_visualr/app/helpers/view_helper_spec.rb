describe "ApplicationController" do
  describe "#render_chart" do
    it "has method" do
      expect(ApplicationController.instance_methods).to include :render_chart
    end

    it "includes method in corresponding helper" do
      expect(ApplicationController.helpers.methods).to  include :render_chart
    end

    it "returns html_safe javascript" do
      controller = ApplicationController.new
      js = controller.render_chart base_chart, "div_chart"
      expect(js).to eq base_chart_js("div_chart")
    end

    it "returns html_safe javascript without script tag" do
      controller = ApplicationController.new
      js = controller.render_chart base_chart, "div_chart", script_tag: false
      expect(js).to eq base_chart_js_without_script_tag("div_chart")
    end
  end
end
