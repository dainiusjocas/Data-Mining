# To change this template, choose Tools | Templates
# and open the template in the editor.


require 'lib/dataset'

describe Dataset do
  before(:each) do
    @dataset = Dataset.new
  end

  it "size of dataset should be equal to 22" do
    @dataset.build_dataset('test/2d.txt')
    @dataset.get_dataset_size.should == 22
  end
  it "length of a datatuple should be equal to 2" do
    @dataset.build_dataset('test/2d.txt')
    @dataset.get_tuple_size.should == 2
  end

end
