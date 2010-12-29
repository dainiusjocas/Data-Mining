# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'lib/k_means'
require 'lib/dataset'

describe KMeans do
  
  before (:each) do
    @dataset = Dataset.new
    @dataset.build_dataset "test/distance_test.txt"
    @k_means = KMeans.new @dataset
  end

  it "method get_new_random_number should always produce new number" do
    random_numbers = Hash.new
    index = 0
    for index in 1..@k_means.working_dataset.get_dataset_size
      @k_means.get_new_random_number random_numbers
    end
    index.should == @k_means.working_dataset.get_dataset_size
  end

  it "size of prepared clustered dataset should be 3" do
    @k_means.get_size_of_clustered_dataset.should == 3
  end

  it "hash value of every key should be -1" do
    @k_means.get_cluster_nr_of_tuple(@dataset.dataset[rand @dataset.get_dataset_size]).should == -1
  end

  it "when clustering is done for the first time the should be 3 changes made" do
    k = 2
    @k_means.build_array_of_k_means 2
    @k_means.recluster_dataset.should == 3
  end

  it "method get_zero_tuple should return array where first element is empty hash and second 0" do
    dataset = Dataset.new
    dataset.build_dataset "test/test_get_zero_tuple.txt"
    k_means = KMeans.new dataset
    zero_tuple = k_means.get_zero_tuple
    (zero_tuple[0] == Hash.new && zero_tuple[1] == 0).should == true
  end
  
  it "method get_zero_tuple should return array where first and second elements are 0 and third is empty hash" do
    zero_tuple = @k_means.get_zero_tuple
    (zero_tuple[0] == 0 && zero_tuple[1] == 0 && zero_tuple[2] == Hash.new).should == true
  end

  it "method get_complete_mean_tuple should return array where first element is equal to 3 second is 5 and third is 'moo'" do
    raw_mean_tuple = [9, 15, {"boo" => 1,"moo" => 2}]
    complete_mean_tuple = @k_means.get_complete_mean_tuple raw_mean_tuple, 3
    (complete_mean_tuple[0] == 3.0 && complete_mean_tuple[1] == 5.0 && complete_mean_tuple[2] == "moo").should == true
  end

  it "method get_complete_mean_tuple should return array where first element is equal to 3 second is 5 and third is 'moo'" do
    raw_mean_tuple = [9, 15, {"moo" => 2, "boo" => 1}]
    complete_mean_tuple = @k_means.get_complete_mean_tuple raw_mean_tuple, 3
    (complete_mean_tuple[0] == 3.0 && complete_mean_tuple[1] == 5.0 && complete_mean_tuple[2] == "moo").should == true
  end

  it "method get_complete_mean_tuple should return zero_tuple_when you give nil instead of mean_tuple with values" do
    raw_mean_tuple = nil
    complete_mean_tuple = @k_means.get_complete_mean_tuple raw_mean_tuple, 0
    complete_mean_tuple.should == [0, 0, Hash.new]
  end

  it "method compute_mean_values_of_cluster should return mean tuple with values [3.0, 5.0, 'moo']" do
    cluster = [[3, 5, "moo"], [3,5, "moo"]]
    @k_means.compute_mean_values_of_cluster(cluster).should == [3.0, 5.0, "moo"]
  end

  it "method compute_mean_values_of_cluster should return mean tuple with values [3.0, 5.0, 'moo']" do
    cluster = [[3, 5, "moo"], [3,5, "moo"], [3, 5, "other_value"]]
    @k_means.compute_mean_values_of_cluster(cluster).should == [3.0, 5.0, "moo"]
  end

  it "method compute_mean_values_of_cluster should return mean tuple with values [3.0, 5.0, 'moo']" do
    cluster = [[1, 5, "moo"], [3,5, "moo"], [5, 5, "other_value"]]
    @k_means.compute_mean_values_of_cluster(cluster).should == [3.0, 5.0, "moo"]
  end

  it "method compute_mean_values_of_cluster should return mean tuple with values [3.0, 5.0, 'moo']" do
    cluster = [[1, 5, "moo"], [3,5, "moo"], [5, 5, "other_value"], [9,5, "moo"]]
    @k_means.compute_mean_values_of_cluster(cluster).should == [4.5, 5.0, "moo"]
  end

  it "clustering of three tuples should produce two clusters of which one size is 1 and other is 2" do
    clustered_dataset = @k_means.clusterize(2).sort{|a,b| a[1]<=>b[1]}
    count_of_cluster_sizes = Hash.new
    clustered_dataset.each { |item|
      if count_of_cluster_sizes.has_key?(item[1])
        count_of_cluster_sizes[item[1]] += 1
      else
        count_of_cluster_sizes[item[1]] = 1
      end
    }
    (count_of_cluster_sizes[0] == 1 || count_of_cluster_sizes[0] == 2 && count_of_cluster_sizes[0] == 1 || count_of_cluster_sizes[0] == 2).should == true
  end
end

