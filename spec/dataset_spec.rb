# To change this template, choose Tools | Templates
# and open the template in the editor.


require 'dataset'

describe Dataset do
  before(:each) do
    @dataset = Dataset.new
  end

  dataset "size of dataset should be equal to 2" do
    @dataset.build_dataset('test/auto_mpg.txt')
    @dataset.get_dataset_size.should == 4
  end
  dataset "length of a datatuple should be equal to 9" do
    @dataset.build_dataset('test/auto_mpg.txt')
    @dataset.get_tuple_size.should == 9
  end


  dataset "normalization constant should be equal to 3" do
    @dataset.build_dataset('test/auto_mpg.txt')
    @dataset.get_norm_const("MPG").should == 3.0
  end
end
