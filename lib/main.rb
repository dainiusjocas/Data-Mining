# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'dataset'

dataset = Dataset.new
dataset.build_dataset "../test/adult.arff"

dataset.get_attribute(5, 1)



