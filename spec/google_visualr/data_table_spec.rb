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

  describe "#new_column" do
    it "initializes a new column with only type param" do
      dt = GoogleVisualr::DataTable.new
      dt.new_column('string')
      dt.cols.first.should == {:id => nil, :label => nil, :type => 'string'}
    end

    it "initializes a new column with all params" do
      dt = GoogleVisualr::DataTable.new
      dt.new_column('string', 'A LABEL', 'col_0')
      dt.cols.first.should == {:id => 'col_0', :label => 'A LABEL', :type => 'string'}
    end
  end

  describe "new_columns" do
    it "initializes new columns" do
      columns = [ {:id => 'A', :label => 'NEW A', :type => 'string'}, {:id => 'B', :label => 'NEW B', :type => 'string'} ]

      dt = GoogleVisualr::DataTable.new
      dt.new_columns(columns)
      dt.cols.first.should  == columns.first
      dt.cols.last.should   == columns.last
    end
  end

  context "column values" do
    before do
      @dt = GoogleVisualr::DataTable.new
      @dt.new_column({:type => 'number'})
      @dt.set_column(0, [1,2,3])
    end

    describe "#set_column" do
      it "sets a column of values to column #index" do
        @dt.rows[0][0].v.should == 1
        @dt.rows[1][0].v.should == 2
        @dt.rows[2][0].v.should == 3
      end
    end

    describe "#get_column" do
      it "retrieves values in column #index" do
        @dt.get_column(0).should == [1,2,3]
      end
    end
  end

  context "row values" do
    before do
      @dt = GoogleVisualr::DataTable.new
      @dt.new_columns( [ {:type => 'number'}, {:type => 'string'} ] )
      @dt.rows.should be_empty
    end

    describe "#add_row" do
      context "when param is empty" do
        it "adds an empty row to the data_table" do
          @dt.add_row
          @dt.rows.size.should == 1
          @dt.rows[0].should be_empty
        end
      end

      context "when param is not empty" do
        it "adds the row values to the data_table" do
          @dt.add_row([1, 'A'])
          @dt.rows.size.should == 1
          @dt.rows[0][0].v.should == 1
          @dt.rows[0][1].v.should == 'A'
        end
      end
    end


    describe "#add_rows" do
      context "when param is number" do
        it "adds x number of empty rows to the data_table" do
          @dt.add_rows(2)
          @dt.rows.size.should == 2
          @dt.rows[0].should be_empty
          @dt.rows[1].should be_empty
        end
      end

      context "when param is an array" do
        it "adds the rows to the data_table" do
          @dt.add_rows( [ [1, 'A'], [2, 'B'] ] )
          @dt.rows.size.should == 2

          @dt.rows[0][0].v.should == 1
          @dt.rows[0][1].v.should == 'A'
          @dt.rows[1][0].v.should == 2
          @dt.rows[1][1].v.should == 'B'
        end
      end
    end

    describe "@get_row" do
      it "retrieves values in row #index" do
        @dt.add_rows( [ [1, 'A'], [2, 'B'] ] )
        @dt.rows.size.should == 2

        @dt.get_row(0).should == [1, 'A']
        @dt.get_row(1).should == [2, 'B']
      end
    end
  end

  context "cell value" do
    before do
      @dt = GoogleVisualr::DataTable.new
      @dt.new_columns( [ {:type => 'number'}, {:type => 'string'} ] )
      @dt.add_row
    end


    describe "#set_cell" do
      it "sets cell" do
        @dt.set_cell(0, 0, 1000)
        @dt.set_cell(0, 1, 'ABCD')

        @dt.get_row(0).should == [1000, 'ABCD']
      end

      it "raises an exception if the row_index or column_index specified is out of range" do
        expect {
          @dt.set_cell(5, 0, 1000)
        }.to raise_exception(RangeError)

        expect {
          @dt.set_cell(0, 5, 1000)
        }.to raise_exception(RangeError)
      end

      it "raises an exception if the value does not correspond to its column type" do
        expect {
          @dt.set_cell(0, 0, 'ABCD')
        }.to raise_exception(ArgumentError)

        expect {
          @dt.set_cell(0, 1, 1234)
        }.to raise_exception(ArgumentError)
      end

      it "accepts 'nil' for all column types" do
        expect {
          @dt.set_cell(0, 0, nil)
        }.to_not raise_exception(ArgumentError)

        expect {
          @dt.set_cell(0, 1, nil)
        }.to_not raise_exception(ArgumentError)
      end
    end

    describe "#get_cell" do
      it "gets cell" do
        @dt.set_cell(0, 0, 1000)
        @dt.get_cell(0, 0).should == 1000
      end

      it "raises an exception if the row_index or column_index specified is out of range" do
        expect {
          @dt.get_cell(0, 5)
        }.to raise_exception(RangeError)

        expect {
          @dt.get_cell(5, 0)
        }.to raise_exception(RangeError)
      end
    end
  end

  describe "#to_js" do
    context "cols" do
      it "includes :id and :label when these are specified" do
        data_table = GoogleVisualr::DataTable.new()
        data_table.new_column("Total", "Total", "1")
        data_table.add_row([1])

        data_table.to_js.should == "var data_table = new google.visualization.DataTable();data_table.addColumn('Total', 'Total', '1');data_table.addRow([{v: 1}]);"
      end

      it "excludes :id and :label when these are not specified" do
        data_table = GoogleVisualr::DataTable.new()
        data_table.new_column("Total")
        data_table.add_row([1])

        data_table.to_js.should == "var data_table = new google.visualization.DataTable();data_table.addColumn('Total');data_table.addRow([{v: 1}]);"
      end
    end

    it "converts object to js string" do
      dt = valid_object
      js = dt.to_js
      js.should match /google.visualization.DataTable/i
      js.should match /addColumn/i
      js.should match /addRow/i
    end
  end

  describe "Cell" do
    describe "#new" do
      it "initializes with a value" do
        cell = GoogleVisualr::DataTable::Cell.new(1)
        cell.v.should == 1
      end

      it "initializes with a hash" do
        cell = GoogleVisualr::DataTable::Cell.new( { :v => 1, :f => "1.0", :p => {:style => 'border: 1px solid green;'} } )
        cell.v.should == 1
        cell.f.should == "1.0"
        cell.p.should == {:style => 'border: 1px solid green;'}
      end
    end

    describe "#to_js" do
      context "initialized with a value" do
        it "returns a json string" do
          cell = GoogleVisualr::DataTable::Cell.new(1)
          cell.to_js.should == "{v: 1}"
        end

        it "returns 'null' when v is nil" do
          cell = GoogleVisualr::DataTable::Cell.new(nil)
          cell.to_js.should == "null"
        end
      end

      context "initialized with a hash" do
        it "returns a json string when v is present" do
          cell = GoogleVisualr::DataTable::Cell.new( { :v => 1, :f => "1.0", :p => {:style => 'border: 1px solid green;'} } )
          cell.to_js.should == "{v: 1, f: '1.0', p: {style: 'border: 1px solid green;'}}"
        end

        it "returns a json string when v is nil" do
          cell = GoogleVisualr::DataTable::Cell.new( { :v => nil, :f => "-", :p => {:style => 'border: 1px solid red;'} } )
          cell.to_js.should == "{v: null, f: '-', p: {style: 'border: 1px solid red;'}}"
        end
      end
    end
  end
end
