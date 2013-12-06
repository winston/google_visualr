require 'spec_helper'

describe "GoogleVisualr::ParamsHelper" do
  module GoogleVisualr
    class Mock
      include GoogleVisualr::ParamHelpers
    end
  end

  before do
    @klass = GoogleVisualr::Mock.new
  end

  describe "#stringify" do
    it "converts symbol keys to string keys" do
      options = @klass.stringify_keys!({:a => 1})
      options.should == {"a" => 1}
    end
  end

  describe "#js_parameters" do
    it "converts params to be js-ready string" do
      options = @klass.js_parameters({:a => 1})
      options.should == "{a: 1}"

      options = @klass.js_parameters({:a => {:b=> 1}})
      options.should == "{a: {b: 1}}"
    end

    it "returns empty string for nil options" do
      options = @klass.js_parameters(nil)
      options.should == ""
    end
  end

  describe "#typecast" do
    def assert_equal(input, expected, type = nil)
      options = @klass.typecast(input, type)
      options.should == expected
    end

    it "returns string" do
      assert_equal("I'm \"AWESOME\"", "I'm \"AWESOME\"".to_json)
    end

    it "returns number" do
      assert_equal(1, 1)
    end

    it "returns boolean" do
      assert_equal(true , "true" )
      assert_equal(false, "false")
    end

    it "returns datetime" do
      date     = DateTime.now
      expected = "new Date(#{date.year}, #{date.month-1}, #{date.day}, #{date.hour}, #{date.min}, #{date.sec})"
      assert_equal(date, expected)
    end

    it "returns time" do
      date     = Time.now
      expected = "new Date(#{date.year}, #{date.month-1}, #{date.day}, #{date.hour}, #{date.min}, #{date.sec})"
      assert_equal(date, expected)
    end

    it "returns time, if specified" do
      date = Time.now
      expected = "new Date(0, 0, 0, #{date.hour}, #{date.min}, #{date.sec})"
      assert_equal(date, expected, "time")
    end

    it "returns date" do
      date     = Date.today
      expected = "new Date(#{date.year}, #{date.month-1}, #{date.day})"
      assert_equal(date, expected)
    end

    it "returns null" do
      assert_equal(nil, "null")
    end

    it "returns array of strings" do
      assert_equal({:colors => ['a', 'b']}, "{colors: [\"a\",\"b\"]}")
    end

    it "recursively calls js_parameters" do
      assert_equal({:a => {:b => {:c => 1}}}, "{a: {b: {c: 1}}}")
    end
  end
end
