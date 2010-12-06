# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'distance'


dataset = Dataset.new
dataset.build_dataset "../test/distance_test.txt"
dataset_size = dataset.get_dataset_size

distance = Distance.new

puts distance.get_distance_between_tuples(dataset.dataset[0], dataset.dataset[2], dataset)





