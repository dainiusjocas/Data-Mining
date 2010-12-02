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

  # Method that finds distance between two numeric values. Result should be in
  # range of (0..1]
  # TODO: what should be if normalization constant is nil?
  #
  # @param value1
  # @param value2
  # @param normalization_constant absolute distance between min and max values between tuples
  #
  def get_distance_between_numeric_values value1, value2, normalization_constant
    if (nil == value1 || nil == value2)
      return 1
    end
    return Float(value1-value2).abs / normalization_constant
  end

  # Method that finds distance between nominal values
  #
  # @param value1
  # @param value2
  #
  def get_distance_between_nominal_values value1, value2
    if (nil == value1 || nil == value2 || value2 != value1)
      return 1
    end
    return 0
  end
end
