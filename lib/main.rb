# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'dataset'
require 'k_means'


dataset = Dataset.new
dataset.build_dataset "../test/auto_mpg.txt"
k_means = KMeans.new dataset
output_file = "../test/output.txt"
number_of_clusters = 2
distance_level = 1
(k_means.clusterize number_of_clusters, distance_level).each { |key, value| puts "#{key} #{value}"}
#k_means.cluster_and_write_clustered_dataset_to_file output_file, number_of_clusters, distance_level
puts "end of the program"