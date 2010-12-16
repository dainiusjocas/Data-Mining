# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'k_means'

describe KMeans do
  
  before(:each) do
    @k_means = KMeans.new
    @sample_dataset = [[1,2,3], [2,3,4], [3,4,5]]
  end

  it "size of unprepared clustered dataset should be 0" do
    @k_means.get_size_of_clustered_dataset.should == 0
  end

  it "size of prepared clustered dataset should be 3" do
    @k_means.prepare_dataset @sample_dataset
    @k_means.get_size_of_clustered_dataset.should == 3
  end

  it "hash value of every key should be -1" do
    @k_means.prepare_dataset @sample_dataset
    @k_means.get_cluster_nr_of_tuple(@sample_dataset[rand @sample_dataset.size]).should == -1
  end

  it "size of array of k means should be equal to k where k is 2" do
    @k_means.prepare_dataset @sample_dataset
    k = 2
    @k_means.build_array_of_k_means @sample_dataset, k
    @k_means.array_of_k_means.size.should == k
  end

  it "when clustering is done for the first time the should be 3 changes made" do
    @k_means.prepare_dataset @sample_dataset
    k = 2
    @k_means.build_array_of_k_means @sample_dataset, k
    @k_means.recluster_dataset.should == 3
  end
end

