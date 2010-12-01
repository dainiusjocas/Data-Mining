# To change this template, choose Tools | Templates
# and open the template in the editor.


load 'dataset.rb'

describe Dataset do
  before(:each) do
    @dataset = Dataset.new
  end

  it "size of dataset should be equal to 2" do
    @dataset.build_dataset('test/auto_mpg.txt')
    @dataset.get_size('dataset').should == 2
  end
  it "length of a datatuple should be equal to 9" do
    @dataset.build_dataset('test/auto_mpg.txt')
    @dataset.get_size('line').should == 9
  end

  it "should return a mpg, num, 18 array" do
    @dataset.build_dataset('test/auto_mpg.txt')
    @dataset.get_attribute(0, 0) == ['mpg', 'num', '18']
  end
end
