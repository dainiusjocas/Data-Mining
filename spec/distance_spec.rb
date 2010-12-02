# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'distance'

describe Distance do
  before(:each) do
    @distance = Distance.new
  end

#====Distance between nominal values============================================
  it "distance between nominal values 0 and 5 should be 1" do
    @distance.get_distance_between_nominal_values(0, 5).should == 1
  end

  it "distance between nominal values 2 and 2 should be 0" do
    @distance.get_distance_between_nominal_values(2, 2).should == 0
  end

  it "distance between nominal values '2' and '3' should be 1" do
    @distance.get_distance_between_nominal_values('2', '3').should == 1
  end
  
  it "distance between nominal values '2' and '2' should be 0" do
    @distance.get_distance_between_nominal_values('2', '2').should == 0
  end

  it "distance between nominal values 'pen' and 'pencil' should be 1" do
    @distance.get_distance_between_nominal_values('2', '3').should == 1
  end

  it "distance between nominal values 'pen' and 'pen' should be 0" do
    @distance.get_distance_between_nominal_values('2', '2').should == 0
  end
#====Distance between numeric values with normalization constant equal to 1=====
  it "distance between numeric values 1 and 5 should be 4 when normalization constant is 1" do
    @distance.get_distance_between_numeric_values(1, 5, 1).should == 4
  end

  it "distance between numeric values -2 and 5 should be 7 when normalization constant is 1" do
    @distance.get_distance_between_numeric_values(-2, 5, 1).should == 7
  end

  it "distance between numeric values 2 and -3 should be 5 when normalization constant is 1" do
    @distance.get_distance_between_numeric_values(2, -3, 1).should == 5
  end

  it "distance between numeric values -5 and -2 should be 3 when normalization constant is 1" do
    @distance.get_distance_between_numeric_values(-5, -2, 1).should == 3
  end

  it "distance between numeric values 10 and 10 should be 0 when normalization constant is 1" do
    @distance.get_distance_between_numeric_values(10, 10, 1).should == 0
  end

#====Distance between numeric values with normalization constant equal to 2=====
  it "distance between numeric values 1 and 5 should be 4 when normalization constant is 2" do
    @distance.get_distance_between_numeric_values(1, 5, 2).should == 2
  end

  it "distance between numeric values -2 and 5 should be 7 when normalization constant is 2" do
    @distance.get_distance_between_numeric_values(-2, 5, 2).should == 3.5
  end

  it "distance between numeric values 2 and -3 should be 5 when normalization constant is 2" do
    @distance.get_distance_between_numeric_values(2, -3, 2).should == 2.5
  end

  it "distance between numeric values -5 and -2 should be 3 when normalization constant is 2" do
    @distance.get_distance_between_numeric_values(-5, -2, 2).should == 1.5
  end

  it "distance between numeric values 10 and 10 should be 0 when normalization constant is 2" do
    @distance.get_distance_between_numeric_values(10, 10, 2).should == 0
  end

  #====Distance between numeric values with normalization constant equal to 2=====
  it "distance between numeric values 1 and 5 should be 8 when normalization constant is 0.5" do
    @distance.get_distance_between_numeric_values(1, 5, 0.5).should == 8
  end

  it "distance between numeric values -2 and 5 should be 14 when normalization constant is 0.5" do
    @distance.get_distance_between_numeric_values(-2, 5, 0.5).should == 14
  end

  it "distance between numeric values 2 and -3 should be 10 when normalization constant is 0.5" do
    @distance.get_distance_between_numeric_values(2, -3, 0.5).should == 10
  end

  it "distance between numeric values -5 and -2 should be 6 when normalization constant is 0.5" do
    @distance.get_distance_between_numeric_values(-5, -2, 0.5).should == 6
  end

  it "distance between numeric values 10 and 10 should be 0 when normalization constant is 0.5" do
    @distance.get_distance_between_numeric_values(10, 10, 0.5).should == 0
  end
end

