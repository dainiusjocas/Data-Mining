# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'distance'

<<<<<<< HEAD
dataset = Dataset.new
dataset.build_dataset "../test/auto_mpg.txt"

dataset.get_attribute(2, 1)
=======
distance = Distance.new

distance.fetch_tuples(0, 1)
@num_value_index = distance.get_num_index
@nom_value_index = distance.get_nom_index
@att_names = distance.dataset_inst.att_names
>>>>>>> ac23811f75980f509ac3ce205e84720849054eb0


puts ""
puts "Numeric value index and name"
@num_value_index.each do |item|
  print item 
  print " "
  puts @att_names.values_at(item)
end

puts ""
puts "Nominal value index and name"
@nom_value_index.each do |item|
  print item
  print " "
  puts @att_names.values_at(item)
end
