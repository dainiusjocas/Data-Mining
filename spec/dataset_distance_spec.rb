require 'dataset'

describe Dataset do
  before(:each) do
    @dataset = Dataset.new
    @dataset.build_dataset "test/distance_test.txt"
  end

#====Distance between nominal values============================================
  it "distance between nominal values 0 and 5 should be 1" do
    @dataset.get_distance_between_nominal_values(0, 5).should == 1
  end

  it "distance between nominal values 2 and 2 should be 0" do
    @dataset.get_distance_between_nominal_values(2, 2).should == 0
  end

  it "distance between nominal values '2' and '3' should be 1" do
    @dataset.get_distance_between_nominal_values('2', '3').should == 1
  end
  
  it "distance between nominal values '2' and '2' should be 0" do
    @dataset.get_distance_between_nominal_values('2', '2').should == 0
  end

  it "distance between nominal values 'pen' and 'pencil' should be 1" do
    @dataset.get_distance_between_nominal_values('2', '3').should == 1
  end

  it "distance between nominal values 'pen' and 'pen' should be 0" do
    @dataset.get_distance_between_nominal_values('2', '2').should == 0
  end

  it "distance between nominal values 'pen' and nil value should be 1" do
    @dataset.get_distance_between_nominal_values('pen', nil).should == 1
  end
  
#====Distance between numeric values with normalization constant equal to 1=====
  it "distance between numeric values 1 and 5 should be 4 when normalization constant is 1" do
    @dataset.get_distance_between_numeric_values(1, 5, 1).should == 4
  end

  it "distance between numeric values -2 and 5 should be 7 when normalization constant is 1" do
    @dataset.get_distance_between_numeric_values(-2, 5, 1).should == 7
  end

  it "distance between numeric values 2 and -3 should be 5 when normalization constant is 1" do
    @dataset.get_distance_between_numeric_values(2, -3, 1).should == 5
  end

  it "distance between numeric values -5 and -2 should be 3 when normalization constant is 1" do
    @dataset.get_distance_between_numeric_values(-5, -2, 1).should == 3
  end

  it "distance between numeric values 10 and 10 should be 0 when normalization constant is 1" do
    @dataset.get_distance_between_numeric_values(10, 10, 1).should == 0
  end

#====Distance between numeric values with normalization constant equal to 2=====
  it "distance between numeric values 1 and 5 should be 4 when normalization constant is 2" do
    @dataset.get_distance_between_numeric_values(1, 5, 2).should == 2
  end

  it "distance between numeric values -2 and 5 should be 7 when normalization constant is 2" do
    @dataset.get_distance_between_numeric_values(-2, 5, 2).should == 3.5
  end

  it "distance between numeric values 2 and -3 should be 5 when normalization constant is 2" do
    @dataset.get_distance_between_numeric_values(2, -3, 2).should == 2.5
  end

  it "distance between numeric values -5 and -2 should be 3 when normalization constant is 2" do
    @dataset.get_distance_between_numeric_values(-5, -2, 2).should == 1.5
  end

  it "distance between numeric values 10 and 10 should be 0 when normalization constant is 2" do
    @dataset.get_distance_between_numeric_values(10, 10, 2).should == 0
  end

  #====Distance between numeric values with normalization constant equal to 2===
  it "distance between numeric values 1 and 5 should be 8 when normalization constant is 0.5" do
    @dataset.get_distance_between_numeric_values(1, 5, 0.5).should == 8
  end

  it "distance between numeric values -2 and 5 should be 14 when normalization constant is 0.5" do
    @dataset.get_distance_between_numeric_values(-2, 5, 0.5).should == 14
  end

  it "distance between numeric values 2 and -3 should be 10 when normalization constant is 0.5" do
    @dataset.get_distance_between_numeric_values(2, -3, 0.5).should == 10
  end

  it "distance between numeric values -5 and -2 should be 6 when normalization constant is 0.5" do
    @dataset.get_distance_between_numeric_values(-5, -2, 0.5).should == 6
  end

  it "distance between numeric values 10 and 10 should be 0 when normalization constant is 0.5" do
    @dataset.get_distance_between_numeric_values(10, 10, 0.5).should == 0
  end

  #====Distance between numeric values when one value is equal to nil===========
  it "distance between numeric values 10 and nil should be 1 when normalization constant is 10" do
    @dataset.get_distance_between_numeric_values(10, nil, 10).should == 1
  end

  it "distance between numeric values nil and 10 should be 1 when normalization constant is 10" do
    @dataset.get_distance_between_numeric_values(nil, 10, 10).should == 1
  end

  it "distance between numeric values nil and nil should be 1 when normalization constant is 10" do
    @dataset.get_distance_between_numeric_values(nil, nil, 10).should == 1
  end

  #====Distance between tuples with mixed values=====
  it "distance between tuples in distance_test.txt at index 0 and 2 should be 1" do
    @dataset.sum_distance_between_tuples(@dataset.dataset[0], @dataset.dataset[2]).should == 1
  end

  it "distance between tuples in distance_test.txt at index 0 and 1 should be 0.4" do
    @dataset.sum_distance_between_tuples(@dataset.dataset[0], @dataset.dataset[1]).should.eql?(0.4)
  end

  it "distance between tuples in distance_test.txt at index 0 and 0 should be 0" do
    @dataset.sum_distance_between_tuples(@dataset.dataset[0], @dataset.dataset[0]).should == 0
  end
end

