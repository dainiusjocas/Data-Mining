#Dataset class stores the dataset generated from the datafile
#datafile must contain a header: first line - attribute names
# =>                             second line - attribute types
#datafile must be a comma separated values file

class Dataset
  attr_accessor :dataset,
    :att_names,
    :normalization_constants,      # array of normalization constants of dataset
    :names_and_types_of_attributes, # hash where key is name and value is type
    :name_of_numeric_type,
    :name_of_nominal_type

  def initialize
    @dataset = Array.new
    @att_names = Array.new
    @normalization_constants = Array.new
    @names_and_types_of_attributes = Hash.new
    #some almost static variables
    @default_normalization_constant = -1
    @name_of_numeric_type = "Numeric"
    @name_of_nominal_type = "Nominal"
  end

  # Method for building a dataset from the given file
  # the dataset is stored in the 2 dimensional array
  # first dimension is the index of tuples
  # second dimension is the index of attributes
  #
  # @param path a path to a 'comma separated value' file containing a dataset
  #
  # First line of the dataset should contain attribute names
  # Second line of the dataset should contain attribute types(numeric or nominal)
  #
  def build_dataset path
    file = File.new(path, "r")
    i = 0
    while (line = file.gets)
       line = line.strip
       unless line.empty?       
         if i == 2 # will not be increased after reaching first tuple
           @dataset.push(line.split(","))
         elsif 0 == i
           line.strip
           @att_names = line.split(",") 
           i += 1
         else
           att_types = line.split(",")
           i += 1
         end
       end
    end
    match_names_of_attributes_with_their_types @att_names, att_types
    count_normalization_constants_for_dataset
  end

  # Method which build an array of normalization constants.
  # If type of attribute is nominal then normalization constant is -1.
  #
  def count_normalization_constants_for_dataset
    @normalization_constants = Array.new # in case you are recounting normalization constants
    for index_of_attribute_of_tuple in 0..(get_tuple_size - 1)
      if (get_type_of_attribute_by_index_of_attribute_of_tuple(index_of_attribute_of_tuple) != @name_of_numeric_type)
        @normalization_constants.push(@default_normalization_constant)
      else
        min_value = nil
        max_value = nil
        @dataset.each do |tuple|
          if (min_value == nil || min_value > tuple[index_of_attribute_of_tuple])
            min_value = tuple[index_of_attribute_of_tuple]
          end

          if (max_value == nil || max_value < tuple[index_of_attribute_of_tuple])
            max_value = tuple[index_of_attribute_of_tuple]
          end
        end
        @normalization_constants.push (Float(min_value) - Float(max_value)).abs
      end
    end
  end

  # Method which builds hash of names and types of attributes
  # So after this we'll be able to get type of attribute by its name
  #
  # @param names_of_attributes array of names of attributes
  # @param types_of_attributes array of types of attributes
  #
  def match_names_of_attributes_with_their_types names_of_attributes, types_of_attributes
    for i in 0..(names_of_attributes.size - 1)
      @names_and_types_of_attributes[names_of_attributes[i]] = types_of_attributes[i]
    end
  end

  # Method which gets attribute type by attribute name
  #
  # @param attribute_name
  # @return type of the attribute which is string value "Numeric" or "Nominal"
  #
  def get_attribute_type_by_name attribute_name
    return @names_and_types_of_attributes[attribute_name]
  end

  # Method which gets name of attribute by index of attribute of tuple
  # If index is bad nil value is to be returned
  # 
  # @param index_of_attribute_of_tuple
  # @return name of the attribute which is string value
  # 
  def get_name_of_attribute_by_index_of_attribute_of_tuple index_of_attribute_of_tuple
    if (index_of_attribute_of_tuple < @att_names.size && index_of_attribute_of_tuple >=0)
      return @att_names[index_of_attribute_of_tuple]
    end
    return nil
  end

  # Method which gets attribute type by index of attribute of tuple
  # If index is bad nil value is to be returned. It is because we are searching
  # in hash and by default if in it there are no such key search returns nil
  #
  # @param index_of_attribute_of_tuple
  # @return type of the attribute which is string value "Numeric" or "Nominal"
  #
  def get_type_of_attribute_by_index_of_attribute_of_tuple index_of_attribute_of_tuple
    return @names_and_types_of_attributes[get_name_of_attribute_by_index_of_attribute_of_tuple index_of_attribute_of_tuple]
  end

  #returns the size of a loaded dataset
  #
  def get_dataset_size
    @dataset.size
  end

  #returns the size of a tuple (number of attributes)
  #
  def get_tuple_size
    @dataset[0].size
  end

  # Method that finds distance between two numeric values. Result should be in
  # range of (0..1].
  # TODO: what should be if normalization constant is nil?
  #
  # @param value1
  # @param value2
  # @param normalization_constant absolute distance between min and max values between tuples
  # @param distance_level optional parameter with default value 1 for manhatan
  #   distance measurement. if you pass 2 euclidean distance is to be computed
  #   and so on.
  #
  def get_distance_between_numeric_values value1, value2, normalization_constant
    if (nil == value1 || nil == value2)
      return 1
    end
     distance = Float(value1.to_f - value2.to_f).abs / normalization_constant
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

  # Method to measure distance between two tuples only by summing differences
  # between attributes of tuple
  #
  # @param tuple1
  # @param tuple2
  # @return distance_between_tuples float value
  # TODO: what about minkovski distance division by size of tuple? I think we
  # don't need to divide, because we said that our dataset don't have missing
  # values
  #
  def get_minkovski_distance_between_tuples tuple1, tuple2, distance_level = 1
    distance_between_tuples = 0
    for index_of_attribute_of_tuple in (0..get_tuple_size - 1)
      if (@name_of_nominal_type == get_type_of_attribute_by_index_of_attribute_of_tuple(index_of_attribute_of_tuple))
        distance_between_tuples += get_distance_between_nominal_values tuple1[index_of_attribute_of_tuple], tuple2[index_of_attribute_of_tuple]
      else
        distance_between_tuples += (get_distance_between_numeric_values tuple1[index_of_attribute_of_tuple], tuple2[index_of_attribute_of_tuple], @normalization_constants[index_of_attribute_of_tuple]) ** distance_level
      end
    end
    if distance_level <= 0
      return (distance_between_tuples ** (1 / 1)) / get_tuple_size
    end
    return (distance_between_tuples ** (1 / distance_level)) / get_tuple_size
  end
end

