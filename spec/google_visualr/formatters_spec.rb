require 'spec_helper'

describe GoogleVisualr::Formatter do

  def valid_object(params={})
    GoogleVisualr::Formatter.new(params)
  end

  describe "#new" do
    it "initializes without params" do
      valid_object.instance_variable_get(:@options).should be_empty
    end

    it "initializes with params" do
      formatter = valid_object( { :width => "150px" } )
      formatter.instance_variable_get(:@options).should == { :width => "150px" }
    end
  end

  describe "#columns" do
    it "sets columns" do
      formatter = valid_object
      formatter.columns(0)
      formatter.instance_variable_get(:@columns).should == [0]
      formatter.columns(1,2)
      formatter.instance_variable_get(:@columns).should == [1,2]
    end
  end

  describe "#options" do
    it "sets options" do
      formatter = valid_object
      formatter.options( :width => "150px", :height => "150px" )
      formatter.instance_variable_get(:@options).should == { "width" => "150px", "height" => "150px" }
    end
  end

  context "GoogleVisualr::ArrowFormat" do
    describe "#to_js" do
      it "works" do
        formatter = GoogleVisualr::ArrowFormat.new(:base => 100)
        formatter.columns(1)
        formatter.to_js.should == "\nvar formatter = new google.visualization.ArrowFormat({base: 100});\nformatter.format(data_table, 1);"
      end
    end
  end

  context "GoogleVisualr::BarFormat" do
    describe "#to_js" do
      it "works" do
        formatter = GoogleVisualr::BarFormat.new(:base => 100, :colorNegative => 'red', :colorPositive => 'green', :drawZeroLine => false, :max => 1000, :min => -1000, :showValue => false,  :width => '150px')
        formatter.columns(1)
        formatter.to_js.should == "\nvar formatter = new google.visualization.BarFormat({base: 100, colorNegative: \"red\", colorPositive: \"green\", drawZeroLine: false, max: 1000, min: -1000, showValue: false, width: \"150px\"});\nformatter.format(data_table, 1);"
      end
    end
  end

  context "GoogleVisualr::ColorFormat" do
    describe "#add_range" do
      it "sets color range" do
        formatter = GoogleVisualr::ColorFormat.new
        formatter.add_range(20000, nil, 'red', '#333333')
        formatter.ranges.should ==  [ {:from => 20000, :to => nil , :color => "red", :bgcolor => "#333333"} ]
      end
    end

    describe "#add_gradient_range" do
      it "sets gradient color range" do
        formatter = GoogleVisualr::ColorFormat.new
        formatter.add_gradient_range(20000, nil, 'red', '#FFFFFF', '#333333')
        formatter.gradient_ranges.should ==  [ {:from => 20000, :to => nil , :color => "red", :fromBgColor => "#FFFFFF", :toBgColor => "#333333"} ]
      end
    end

    describe "#to_js" do
      it "works" do
        formatter = GoogleVisualr::ColorFormat.new
        formatter.add_range(0, 1000, 'red', '#000000')
        formatter.add_gradient_range(2000, nil, 'blue', '#FFFFFF', '#333333')
        formatter.columns(1)
        formatter.to_js.should == "\nvar formatter = new google.visualization.ColorFormat();\nformatter.addRange(0, 1000, \"red\", \"#000000\");\nformatter.addGradientRange(2000, null, \"blue\", \"#FFFFFF\", \"#333333\");\nformatter.format(data_table, 1);"
      end
    end
  end

  context "GoogleVisualr::DateFormat" do
    describe "#to_js" do
      it "works" do
        formatter = GoogleVisualr::DateFormat.new(:formatType => 'long', :timeZone => 8)
        formatter.columns(1)
        formatter.to_js.should == "\nvar formatter = new google.visualization.DateFormat({formatType: \"long\", timeZone: 8});\nformatter.format(data_table, 1);"
      end
    end
  end

  context "GoogleVisualr::NumberFormat" do
    describe "#to_js" do
      it "works" do
        formatter = GoogleVisualr::NumberFormat.new(:decimalSymbol => '.', :fractionDigits => 4, :groupingSymbol => ',', :negativeColor => 'red', :negativeParens => false, :prefix => 'USD$', :suffix => '-')
        formatter.columns(1)
        formatter.to_js.should == "\nvar formatter = new google.visualization.NumberFormat({decimalSymbol: \".\", fractionDigits: 4, groupingSymbol: \",\", negativeColor: \"red\", negativeParens: false, prefix: \"USD$\", suffix: \"-\"});\nformatter.format(data_table, 1);"
      end
    end
  end
end
