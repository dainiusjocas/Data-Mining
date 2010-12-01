# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'dataset'

dataset = Dataset.new
dataset.build_dataset "../test/auto_mpg.txt"

dataset.get_attribute(2, 1)



