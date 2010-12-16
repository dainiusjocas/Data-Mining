# This class is for clustering dataset by k-means algorithm
# Work of this class is more or less independent from what kind of data set.
# version 0.1

# TODO
# 1. What to do if k is less than 1
# 2. What is the treshold to stop doing clustering
require 'dataset'

class KMeans

  attr_accessor :clustered_dataset, # hash where key is a tuple, value is number of cluster
    :array_of_k_means # array of arrays which are like vectors of mean values of clusters

  def initialize
    @clustered_dataset = Hash.new
    @array_of_k_means = Array.new
  end

  def get_size_of_clustered_dataset
    return @clustered_dataset.size
  end

  def get_cluster_nr_of_tuple tuple
    return @clustered_dataset[tuple]
  end

  # Builds a hash where key is tuple and the value is -1. Value is -1 because
  # at the beginning we don't know to which cluster tuple belongs
  #
  # @param dataset - array of tuples, where tuple can be any kind of object
  #
  def prepare_dataset dataset
    dataset.each { |tuple| @clustered_dataset[tuple] = -1 }
  end

  # initializes array of mean values by picking k values from clustered dataset
  # randomly.
  #
  # @dataset array of tuples
  # @param k number of clusters
  #
  def build_array_of_k_means dataset, k
    for i in 0..k-1
      @array_of_k_means[i] = dataset[rand dataset.size]
    end
  end

  # clustering. Go through every tuple and measure distance between tuple and
  # mean values. After measuring we have number of cluster to which distance of
  # current tuple is minimal. Then we assign this number to tuple.
  #
  # TODO figure out how to measure distance between two tuples in this
  # circumstances
  #
  def recluster_dataset
    changes_made_during_clustering = 0
    @clustered_dataset.each do |tuple, value|
      minimal_distance = nil
      new_value = nil
      i = 0  # for saving cluster number

      @array_of_k_means.each do |mean|
        distance = 1 # measure distance between tuple and mean
        if (minimal_distance == nil || minimal_distance > distance)
          minimal_distance = distance
          new_value = i
        end
        i += 1 #we'll check next cluster
      end

      if (value != new_value) # this 'if' is faster than just reassign value to array
        @clustered_dataset[tuple] = new_value
        changes_made_during_clustering += 1
      end

    end
    return changes_made_during_clustering
  end

  def count_mean_values_within_clusters

  end
end
