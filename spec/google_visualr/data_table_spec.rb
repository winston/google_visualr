require 'spec_helper'

describe GoogleVisualr::DataTable do

  def valid_object

    @cols = [
              { :id => 'A', :label => 'NEW A'  , :type => 'string' },
              { :id => 'B', :label => 'B-label', :type => 'number' },
              { :id => 'C', :label => 'C-label', :type => 'date'   }
            ]
    @rows = [
              { :c => [ {:v => 'a'}, {:v => 1.0, :f => 'One'}  , {:v => Date.parse('2008-02-28 00:31:26'), :f => '2/28/08 12:31 AM'} ] },
              { :c => [ {:v => 'b'}, {:v => 2.0, :f => 'Two'}  , {:v => Date.parse('2008-03-30 00:31:26'), :f => '3/30/08 12:31 AM'} ] },
              { :c => [ {:v => 'c'}, {:v => 3.0, :f => 'Three'}, {:v => Date.parse('2008-04-30 00:31:26'), :f => '4/30/08 12:31 AM'} ] }
            ]
    GoogleVisualr::DataTable.new({:cols => @cols, :rows => @rows})

  end

  describe "#new" do
    it "initializes without params" do
      dt = GoogleVisualr::DataTable.new
      dt.should_not be_nil
      dt.cols.should be_a_kind_of Array
      dt.rows.should be_a_kind_of Array
    end

    it "initializes with params" do
      dt = valid_object

      @cols.size.times do |i|
        dt.cols[i].should == @cols[i]
      end

      @rows.size.times do |i|
        @cols.size.times do |j|
          cell = dt.rows[i][j]
          cell.should be_a_kind_of GoogleVisualr::DataTable::Cell
          cell.v.should == @rows[i][:c][j][:v]
          cell.f.should == @rows[i][:c][j][:f]
        end
      end
    end
  end
  
  describe "#add_column" do
  end
  
  describe "#add_columns" do
  end
  
  describe "#get_column_values" do
  end

  describe "#add_row" do
  end

  describe "#add_rows" do
  end
  
  describe "#get_row_values" do
  end
  
  describe "#to_js" do
    it "converts object to js string" do
      dt = valid_object
      js = dt.to_js
      js.should match /google.visualization.DataTable/i
      js.should match /addColumn/i
      js.should match /addRow/i
    end
  end

end