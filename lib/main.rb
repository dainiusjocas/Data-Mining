require 'lib/dataset'
require 'lib/k_means'

#4. ruby main [dataset_file], [output_file], [name_of_algorithm], [[number_of_clusters], [distance_level]]
dataset = Dataset.new
dataset.build_dataset "test/adult.arff"#ARGV[0]
output_file = ARGV[1]
ARGV.each { |arg| puts arg }
if ("k_means" == ARGV[2])
  k_means = KMeans.new dataset
  number_of_clusters = ARGV[3].to_i
  distance_level = ARGV[4].to_i
  start = Time.new
  #(k_means.clusterize number_of_clusters, distance_level).each { |key, value| puts "#{key} #{value}"}
  k_means.cluster_and_write_clustered_dataset_to_file output_file, number_of_clusters, distance_level
  duration = Time.new - start
  puts "#{duration} seconds"
elsif ("db_scan"== ARGV[2])
  puts "not yet implemented"
end

puts "end of the program"