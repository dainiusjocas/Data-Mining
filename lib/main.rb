require 'lib/dataset'
require 'lib/k_means'
require 'lib/db_scan'

#4. ruby main [dataset_file], [output_file], [name_of_algorithm], [[number_of_clusters], [distance_level]]
dataset = Dataset.new

dataset.build_dataset ARGV[0]
output_file = ARGV[1]
if ("k_means" == ARGV[2])
  k_means = KMeans.new dataset
  number_of_clusters =  ARGV[3].to_i
  distance_level = ARGV[4].to_i
  start = Time.new
  k_means.cluster_and_write_clustered_dataset_to_file output_file, number_of_clusters, distance_level
  duration = Time.new - start
  puts "Execution time is #{duration} seconds"
elsif ("db_scan"== ARGV[2])
  dbscan = Dbscan.new dataset
  min_distance = ARGV[3].to_f
  min_number_of_points = ARGV[4].to_i
  time_before = Time.now
  dbscan.cluster_and_write_clustered_dataset_to_file output_file, min_distance, min_number_of_points
  time_after = Time.now
  puts "Execution time is #{time_after-time_before} seconds"
end

puts "end of the program"
