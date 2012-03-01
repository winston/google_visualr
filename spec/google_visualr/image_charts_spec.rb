require 'spec_helper'

describe GoogleVisualr::Image::PieChart do
  describe "#uri" do
    let(:chart){ GoogleVisualr::Image::PieChart.new( data_table, {} )}
    image_pie_options.each_with_index do |opts, i|
      context "#{opts.inspect}" do
        it "generates correct URI" do
          chart.options = opts
          uri = chart.uri
          #puts uri.to_s
          CGI.parse(uri.query).should == CGI.parse(image_pie_chart_uris[i].query)
        end
      end
    end
  end
end

describe GoogleVisualr::Image::LineChart do
  describe "#uri" do
    let(:chart){ GoogleVisualr::Image::LineChart.new( data_table, {} )}
    image_line_options.each_with_index do |opts, i|
      context "#{opts.inspect}" do
        it "generates correct URI" do
          chart.options = opts
          uri = chart.uri
          #puts uri.to_s
          CGI.parse(uri.query).should == CGI.parse(image_line_chart_uris[i].query)
        end
      end
    end
  end
end

describe GoogleVisualr::Image::BarChart do
  describe "#uri" do
    let(:chart){ GoogleVisualr::Image::BarChart.new( data_table, {} )}
    image_bar_options.each_with_index do |opts, i|
      context "#{opts.inspect}" do
        it "generates correct URI" do
          chart.options = opts
          uri = chart.uri
          #puts uri.to_s
          CGI.parse(uri.query).should == CGI.parse(image_bar_chart_uris[i].query)
        end
      end
    end
  end
end

describe GoogleVisualr::Image::SparkLine do
  describe "#uri" do
    let(:chart){ GoogleVisualr::Image::SparkLine.new( data_table, {} )}
    sparkline_options.each_with_index do |opts, i|
      context "#{opts.inspect}" do
        it "generates correct URI" do
          chart.options = opts
          uri = chart.uri
          #puts uri.to_s
          CGI.parse(uri.query).should == CGI.parse(sparkline_uris[i].query)
        end
      end
    end
  end
end