# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'distance'


dataset = Dataset.new
dataset.build_dataset "../test/auto_mpg.txt"
#dataset.get_attribute(2, 1)

dataset.get_norm_const("MPG")



