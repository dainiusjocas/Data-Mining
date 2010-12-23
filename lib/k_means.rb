# This class is for clustering dataset by k-means algorithm
# Work of this class is more or less independent from what kind of data set.
# version 0.1

# TODO
# 1. What to do if k is less than 1
# 2. What is the treshold to stop doing clustering
# 3. Get array about mean values of cluster

require 'dataset'

class KMeans

  attr_accessor :clustered_dataset, # hash where key is a tuple, value is number of cluster
    :array_of_k_means, # array of arrays which are like vectors of mean values of clusters
    :working_dataset, #object of class Dataset
    :k,       # k value
    :treshold # level of minimum changes made per clustering

  def initialize dataset
    @clustered_dataset = Hash.new
    @array_of_k_means = Array.new
    @working_dataset = dataset
    prepare_dataset
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
  # @param dataset - dataset of tuples, where tuple can be any kind of object
  #
  def prepare_dataset
    @working_dataset.dataset.each { |tuple| @clustered_dataset[tuple] = -1 }
  end

  # initializes array of mean values by picking k values from clustered dataset
  # randomly.
  #
  def build_array_of_k_means k
    random_numbers = Hash.new
    for i in 0..k-1
      @array_of_k_means[i] = @working_dataset.dataset[get_new_random_number random_numbers]
    end
  end

  # Method which always returns random number. Clustering needs such method
  # because if we would have situation when mean of two clusters is the same
  # value, then we would have one empty cluster which doesn't make sense.
  #
  # @param hash of previously used numbers
  #
  def get_new_random_number random_numbers
    random_number = 0
    begin
      random_number = rand @working_dataset.get_dataset_size
    end while (random_numbers.has_key?(random_number))
    random_numbers[random_number] = 1
    return random_number
  end

  # This methods starts to iterate through dataset. Work stops when treshold of 
  # changes is reached.
  # 
  # @param k how many clusters we want to do - default value 2
  # @param treshold_of_min_changes - end condition - default value 10
  #
  def clusterize k = 2, distance_level = 1
    return nil if k > @working_dataset.get_dataset_size
    build_array_of_k_means k
    clustered = false # identifies if dataset is preclusterized. if flag == 0 then there are no mean values
    begin
      recompute_mean_values_within_clusters k if clustered == true
      number_of_changes = recluster_dataset distance_level
      clustered = true
    end while 0 < number_of_changes
    return @clustered_dataset
  end

  # clustering. Go through every tuple and measure distance between tuple and
  # mean values. After measuring we have number of cluster to which distance of
  # current tuple is minimal. Then we assign this number to tuple.
  #
  # TODO figure out how to measure distance between two tuples in this
  # circumstances
  #
  def recluster_dataset distance_level = 1
    changes_made_during_clustering = 0
    
    @clustered_dataset.each do |tuple, cluster|
      minimal_distance = nil
      new_cluster_value = nil
      i = 0  # for saving cluster number
      for cluster_index in 0..@array_of_k_means.size - 1
        distance = @working_dataset.get_minkovski_distance_between_tuples tuple, @array_of_k_means[cluster_index], distance_level
        if (minimal_distance == nil || minimal_distance > distance)
          minimal_distance = distance
          new_cluster_value = cluster_index
        end
      end

      if (cluster != new_cluster_value) # this 'if' is faster than just reassign value to hash
        @clustered_dataset[tuple] = new_cluster_value
        changes_made_during_clustering += 1
      end

    end
    return changes_made_during_clustering
  end

  # after every clustering mean values of cluster should be recomputed
  #
  # @param k how many clusters we have
  #
  def recompute_mean_values_within_clusters k
    for index_of_cluster in 0..(k - 1) # for each cluster we go through all dataset
      temp_cluster = Array.new
      @clustered_dataset.each do |tuple, cluster|
        if cluster == index_of_cluster
          temp_cluster.push(tuple)
        end
      end
      @array_of_k_means[index_of_cluster] = compute_mean_values_of_cluster temp_cluster
    end
  end

  # Computes mean value of cluster
  #
  # @param cluster array of tuples
  # @return mean tuple of cluster
  #
  def compute_mean_values_of_cluster cluster
    mean_tuple = get_zero_tuple
    cluster.each do |tuple|

      for attribute_index in 0..mean_tuple.size - 1
        #if @workind_dataset.name_of_nominal_type == @working_dataset.get_type_of_attribute_by_index_of_attribute_of_tuple(attribute_index)
        if "Nominal" == @working_dataset.get_type_of_attribute_by_index_of_attribute_of_tuple(attribute_index)
          if mean_tuple[attribute_index].has_key?(tuple[attribute_index])
            mean_tuple[attribute_index][tuple[attribute_index]] = mean_tuple[attribute_index][tuple[attribute_index]] + 1
          else
            mean_tuple[attribute_index][tuple[attribute_index]] = 1
          end
        else
          mean_tuple[attribute_index] += tuple[attribute_index].to_i
        end
      end
    end
    
    mean_tuple = get_complete_mean_tuple mean_tuple, cluster.size
    return mean_tuple
  end

  # Method which returns mean tuple of cluster. It counts arithmetic average of
  # numeric values and takes the most frequent nominal values and assigns
  # results to complete mean tuple
  #
  # @param raw_mean_tuple tuple with sums of numeric values and hashes of
  #   nominal values, where key is the nominal value, value is frequency of this
  #   value
  # @param size_of_cluster
  # @return array (or tuple) of mean values within cluster
  #
  def get_complete_mean_tuple raw_mean_tuple, size_of_cluster
    complete_mean_tuple = get_zero_tuple
    if 0 < size_of_cluster
      for attribute_index in 0..@working_dataset.dataset[0].size - 1
        #if @workind_dataset.name_of_nominal_type == @working_dataset.get_type_of_attribute_by_index_of_attribute_of_tuple(attribute_index)
        if "Nominal" == @working_dataset.get_type_of_attribute_by_index_of_attribute_of_tuple(attribute_index)
          array_of_sorted_nominal_values = raw_mean_tuple[attribute_index].sort {|a,b| a[1]<=>b[1]}
          array_of_sorted_nominal_values.reverse!
          complete_mean_tuple[attribute_index] = array_of_sorted_nominal_values[0][0]
        else
          complete_mean_tuple[attribute_index] = Float(raw_mean_tuple[attribute_index])/ size_of_cluster
        end
      end
    end
    return complete_mean_tuple
  end

  # Method which makes tuple which has value of 0 for numeric attribute and
  # empty hash for nominal values
  #
  # @return zero_tuple tuple with neutral values
  #
  def get_zero_tuple
    zero_tuple = Array.new(@working_dataset.dataset[0].size)
    for attribute_index in 0..zero_tuple.size - 1
      #if @workind_dataset.name_of_nominal_type == @working_dataset.get_type_of_attribute_by_index_of_attribute_of_tuple(attribute_index)
      if "Nominal" == @working_dataset.get_type_of_attribute_by_index_of_attribute_of_tuple(attribute_index)
        zero_tuple[attribute_index] = Hash.new
      else
        zero_tuple[attribute_index] = 0
      end
    end
    return zero_tuple
  end

  # This method outputs clusterized array to file
  def cluster_and_write_clustered_dataset_to_file file_name, number_of_clusters, distance_level
    result = clusterize number_of_clusters, distance_level
    File.open(file_name, 'w') {|f|

      attribute_types = ""
      attribute_names = ""
      @working_dataset.names_and_types_of_attributes.each {|attribute_name, attribute_type|
        attribute_names << "#{attribute_name},"
        attribute_types << "#{attribute_type},"
      }
      f.puts attribute_names.chop
      f.puts attribute_types.chop

      temp_string = ""
      result.each { |key,value|
        key.each{ |attribute| temp_string << "#{attribute}," }
        f.puts("#{temp_string}#{value}")
        temp_string = ""
      }
    }
  end
end
