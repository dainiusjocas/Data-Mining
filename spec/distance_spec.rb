# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'distance'

describe Distance do
  before(:each) do
    @distance = Distance.new
  end

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
#===============================================================================
  it "distance between numeric values 1 and 5 should be 4" do
    @distance.get_distance_between_numeric_values(1, 5).should == 4
  end

  it "distance between numeric values -2 and 5 should be 7" do
    @distance.get_distance_between_numeric_values(-2, 5).should == 7
  end

  it "distance between numeric values 2 and -3 should be 5" do
    @distance.get_distance_between_numeric_values(2, -3).should == 5
  end

  it "distance between numeric values -5 and -2 should be 3" do
    @distance.get_distance_between_numeric_values(-5, -2).should == 3
  end

  it "distance between numeric values 10 and 10 should be 0" do
    @distance.get_distance_between_numeric_values(10, 10).should == 0
  end
end

