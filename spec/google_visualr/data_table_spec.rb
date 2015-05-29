require 'spec_helper'

describe GoogleVisualr::DataTable do

  let(:dt) { GoogleVisualr::DataTable.new }

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
      dt.new_column('string')
      dt.cols.first.should == {:type => 'string'}
    end

    it "initializes a new column with all params" do
      dt.new_column('string', 'A LABEL', 'col_0')
      dt.cols.first.should == {:id => 'col_0', :label => 'A LABEL', :type => 'string'}
    end

    it "initializes a new column with experimental role param" do
      dt.new_column('string', nil, nil, 'interval', 'pattern')
      dt.cols.first.should == {:type => 'string', :role => 'interval', :pattern => 'pattern'}
    end
  end

  describe "new_columns" do
    it "initializes new columns (with experimental support)" do
      columns = [
        {:id => 'A', :label => 'NEW A', :type => 'string'},
        {:id => 'B', :label => 'NEW B', :type => 'string'},
        {:type => 'string', :role => 'interval', :pattern => 'pattern'}
      ]

      dt.new_columns(columns)
      dt.cols[0].should == columns[0]
      dt.cols[1].should == columns[1]
      dt.cols[2].should == columns[2]
    end
  end

  context "column values" do
    before do
      dt.new_column({:type => 'number'})
      dt.set_column(0, [1,2,3])
    end

    describe "#set_column" do
      it "sets a column of values to column #index" do
        dt.rows[0][0].v.should == 1
        dt.rows[1][0].v.should == 2
        dt.rows[2][0].v.should == 3
      end
    end

    describe "#get_column" do
      it "retrieves values in column #index" do
        dt.get_column(0).should == [1,2,3]
      end
    end
  end

  context "row values" do
    before do
      dt.new_columns( [ {:type => 'number'}, {:type => 'string'} ] )
      dt.rows.should be_empty
    end

    describe "#add_row" do
      context "when param is empty" do
        it "adds an empty row to the data_table" do
          dt.add_row
          dt.rows.size.should == 1
          dt.rows[0].should be_empty
        end
      end

      context "when param is not empty" do
        it "adds the row values to the data_table" do
          dt.add_row([1, 'A'])
          dt.rows.size.should == 1
          dt.rows[0][0].v.should == 1
          dt.rows[0][1].v.should == 'A'
        end
      end
    end

    describe "#add_rows" do
      context "when param is number" do
        it "adds x number of empty rows to the data_table" do
          dt.add_rows(2)
          dt.rows.size.should == 2
          dt.rows[0].should be_empty
          dt.rows[1].should be_empty
        end
      end

      context "when param is an array" do
        it "adds the rows to the data_table" do
          dt.add_rows( [ [1, 'A'], [2, 'B'] ] )
          dt.rows.size.should == 2

          dt.rows[0][0].v.should == 1
          dt.rows[0][1].v.should == 'A'
          dt.rows[1][0].v.should == 2
          dt.rows[1][1].v.should == 'B'
        end
      end
    end

    describe "@get_row" do
      it "retrieves values in row #index" do
        dt.add_rows( [ [1, 'A'], [2, 'B'] ] )
        dt.rows.size.should == 2

        dt.get_row(0).should == [1, 'A']
        dt.get_row(1).should == [2, 'B']
      end
    end
  end

  context "cell value" do
    before do
      dt.new_columns( [ {:type => 'string'}, {:type => 'number'}, {:type => 'boolean'}, {:type => 'datetime'}, {:type => 'date'} ] )
      dt.add_row
    end

    describe "#set_cell" do
      it "sets cell" do
        dt.set_cell(0, 0, {:v => 'ABCD'})
        dt.set_cell(0, 1, 1000)

        dt.get_row(0).should == ['ABCD', 1000]
      end

      it "raises an exception if the row_index or column_index specified is out of range" do
        expect {
          dt.set_cell(5, 0, 1000)
        }.to raise_exception(RangeError)

        expect {
          dt.set_cell(0, 5, 1000)
        }.to raise_exception(RangeError)
      end

      describe "#verify_against_column_type" do
        def assert_raises_exception(col, value)
          expect {
            dt.set_cell(0, col, value)
          }.to raise_exception(ArgumentError)
        end

        it "raises an exception if value is not string" do
          assert_raises_exception(0, 1234)
        end

        it "raises an exception if value is not number" do
          assert_raises_exception(1, 'ABCD')
        end

        it "raises an exception if value is not boolean" do
          assert_raises_exception(2, 'ABCD')
        end

        it "raises an exception if value is not datetime or time" do
          assert_raises_exception(3, 'ABCD')
        end

        it "raises an exception if value is not date" do
          assert_raises_exception(4, 'ABCD')
        end

        it "accepts BigDecimal as number" do
          expect {
            dt.set_cell(0, 1, BigDecimal.new(42))
          }.to_not raise_exception
        end
      end

      it "accepts 'nil' for all column types" do
        expect {
          dt.set_cell(0, 0, nil)
        }.to_not raise_exception
      end
    end

    describe "#get_cell" do
      it "gets cell" do
        dt.set_cell(0, 0, 'ABCD')
        dt.get_cell(0, 0).should == 'ABCD'
      end

      it "raises an exception if the row_index or column_index specified is out of range" do
        expect {
          dt.get_cell(0, 5)
        }.to raise_exception(RangeError)

        expect {
          dt.get_cell(5, 0)
        }.to raise_exception(RangeError)
      end
    end
  end

  describe "#to_js" do
    context "cols" do
      it "includes :id and :label when these are specified" do
        dt.new_column('number', 'Total', '1')
        dt.add_row([1])

        dt.to_js.should == "var data_table = new google.visualization.DataTable();data_table.addColumn({\"type\":\"number\",\"label\":\"Total\",\"id\":\"1\"});data_table.addRow([{v: 1}]);"
      end

      it "excludes :id and :label when these are not specified" do
        dt.new_column('number')
        dt.add_row([1])

        dt.to_js.should == "var data_table = new google.visualization.DataTable();data_table.addColumn({\"type\":\"number\"});data_table.addRow([{v: 1}]);"
      end

      it "includes :role and :pattern when these are specified" do
        dt.new_column('string', nil, nil, 'interval', 'pattern')
        dt.add_row(['interval'])

        dt.to_js.should == "var data_table = new google.visualization.DataTable();data_table.addColumn({\"type\":\"string\",\"role\":\"interval\",\"pattern\":\"pattern\"});data_table.addRow([{v: \"interval\"}]);"
      end

      it "escapes labels with apostrophes properly" do
        dt.new_column('number', 'Winston\'s')
        dt.add_row([1])

        dt.to_js.should == "var data_table = new google.visualization.DataTable();data_table.addColumn({\"type\":\"number\",\"label\":\"Winston's\"});data_table.addRow([{v: 1}]);"
      end
    end

    context "valid object literal" do
      it "converts object to js string" do
        dt = valid_object
        js = dt.to_js
        js.should match /google.visualization.DataTable/i
        js.should match /addColumn/i
        js.should match /addRow/i
      end
    end
  end

  describe "Cell" do
    describe "#new" do
      it "initializes with a value" do
        cell = GoogleVisualr::DataTable::Cell.new(1)
        cell.v.should == 1
      end

      it "initializes with a hash" do
        cell = GoogleVisualr::DataTable::Cell.new( { :v => 1, :f => "1.0", :p => {:style => "border: 1px solid green;"} } )
        cell.v.should == 1
        cell.f.should == "1.0"
        cell.p.should == {:style => "border: 1px solid green;"}
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
          cell = GoogleVisualr::DataTable::Cell.new( { :v => 1, :f => "1.0", :p => {:style => "border: 1px solid green;"} } )
          cell.to_js.should == "{v: 1, f: \"1.0\", p: {style: \"border: 1px solid green;\"}}"
        end

        it "returns a json string when v is nil" do
          cell = GoogleVisualr::DataTable::Cell.new( { :v => nil, :f => "-", :p => {:style => "border: 1px solid red;"} } )
          cell.to_js.should == "{v: null, f: \"-\", p: {style: \"border: 1px solid red;\"}}"
        end

        it "returns a valid json string when there are apostrophes in v or f" do
          cell = GoogleVisualr::DataTable::Cell.new( { :v => "I'm \"Winston\"", :f => "Winston<div style='color:red; font-style:italic'>Nice Guy</div>" } )
          expected = "{v: \"I'm \\\"Winston\\\"\", f: \"Winston<div style='color:red; font-style:italic'>Nice Guy</div>\"}"

          expect(normalize_javascript(cell.to_js)).to eq expected
        end
      end
    end
  end
end
