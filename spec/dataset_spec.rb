# To change this template, choose Tools | Templates
# and open the template in the editor.


load 'dataset.rb'

describe Dataset do
  before(:each) do
    @dataset = Dataset.new
  end

  it "size of dataset should be equal to 2" do
    @dataset.build_dataset('test/auto_mpg.txt')
    @dataset.get_size.should == 2
  end
end

