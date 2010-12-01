# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'dataset'

class Distance
  attr_accessor :tuple_i, :tuple_j, :nom_index, :num_index, :dataset_inst

  def initialize
    @tuple_i = Array.new
    @tuple_j = Array.new
    @nom_index = Array.new
    @num_index = Array.new
    @dataset_inst = Array.new
  end


  def fetch_tuples (i, j)
    @dataset_inst = Dataset.new
    @dataset_inst.build_dataset('../test/auto_mpg.txt')
    @tuple_i = @dataset_inst.dataset[i]
    @tuple_j = @dataset_inst.dataset[j]
  end
   

  #gets the index of numerical attributes in the dataset
  def get_num_index
    idx = 0
    @dataset_inst.att_types.each do |e|
      if e=='Numeric'
        @num_index.push(idx)
        idx +=1
      else
        idx += 1
      end
    end
    return @num_index
  end

  #gets the index of numerical attributes in the dataset
  def get_nom_index
    idx = 0
    @dataset_inst.att_types.each do |e|
      if e=='Nominal'
        @nom_index.push(idx)
        idx +=1
      else
        idx += 1
      end
    end
    return @nom_index
  end

end
