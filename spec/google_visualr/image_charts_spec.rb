require 'spec_helper'

describe GoogleVisualr::Image::PieChart do

  before do
    @pie_chart = image_pie_chart
  end

  describe "#uri" do
    it "generates GET url" do
      uri = @pie_chart.uri
      CGI.parse(uri.query).should == CGI.parse(image_pie_chart_uri.query)
      uri.host.should == image_pie_chart_uri.host
    end
  end

end

describe GoogleVisualr::Image::LineChart do

  before do
    @line_chart = image_line_chart
  end

  describe "#uri" do
    it "generates GET uri" do
      uri = @line_chart.uri
      CGI.parse(uri.query).should == CGI.parse(image_line_chart_uri.query)
      uri.host.should == image_line_chart_uri.host
    end
  end

end

describe GoogleVisualr::Image::BarChart do

  before do
    @bar_chart = image_bar_chart
  end

  describe "#uri" do
    it "generates GET uri" do
      uri = @bar_chart.uri
      CGI.parse(uri.query).should == CGI.parse(image_bar_chart_uri.query)
      uri.host.should == image_bar_chart_uri.host
    end
  end

end