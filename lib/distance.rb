# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'dataset'

class Distance

  def initialize
    
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
     distance = Float(value1.to_f-value2.to_f).abs / normalization_constant
    return distance
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



  # Method that finds distance between two tuples.
  # Returns a value between 0 and 1, that specifies the distance
  # between two given tuples.
  #
  # @param tuple_i
  # @param tuple_j
  # @param dataset
   def get_distance_between_tuples tuple_i, tuple_j, dataset
     idx = 0
     dist = Array.new
     dist_f = Array.new
     dist_sum = 0
     tuple_size = dataset.get_tuple_size
     divide_by = tuple_size
     


     (0..tuple_size).each do |i|
       if dataset.att_types.values_at(idx)[0] == "Nominal"
         if tuple_i.values_at(idx)[0] == "0" || tuple_j.values_at(idx)[0] == "0"
           dist.push(0)
           divide_by -= 1
         else
           dist.push(get_distance_between_nominal_values(tuple_i.values_at(idx)[0], tuple_j.values_at(idx)[0]))
         end
       end

       if dataset.att_types.values_at(idx)[0] == "Numeric"
         if tuple_i.values_at(idx)[0] == "0" || tuple_j.values_at(idx)[0] == "0"
           dist.push(0)
           divide_by -= 1
         else
           dist.push(get_distance_between_numeric_values(tuple_i.values_at(idx)[0], tuple_j.values_at(idx)[0], dataset.get_norm_const(dataset.att_names.values_at(idx)[0])))
         end
       end
       idx += 1
     end

     dist.each do |item|
       dist_f.push(item.to_f)
     end
     dist_f.each do |d|
       unless d == 0.0
        dist_sum += d
       end
     end
     puts dist
     return dist_sum/divide_by
  end
end
