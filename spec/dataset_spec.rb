# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'dataset'

describe Dataset do
  before(:each) do
    @dataset = Dataset.new
  end

  it "size of the dataset should be 2 tuples" do
    @dataset.build_dataset('../test/auto_mpg_test.txt')
    @dataset.dataset.size.should == 2
  end
end

