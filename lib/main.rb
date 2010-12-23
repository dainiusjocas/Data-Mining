# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'dataset'
require 'k_means'


dataset = Dataset.new
dataset.build_dataset "../test/auto_mpg.txt"
k_means = KMeans.new dataset
number_of_clusters = 2
distance_level = 1 # strange results with distance level larger than one
(k_means.clusterize number_of_clusters, distance_level).each { |key, value| puts "#{key} #{value}"}
#k_means.write_clustered_dataset_to_file number_of_clusters, file_name







