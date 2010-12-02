#Dataset class stores the dataset generated from the datafile
#datafile must contain a header: first line - attribute names
# =>                             second line - attribute types
#datafile must be a comma separated values file

class Dataset
  attr_accessor :dataset, :att_names, :att_types

  #constructor of the class, initializing the class variables
  def initialize
    @dataset = Array.new
    @att_names = Array.new
    @att_types = Array.new
    
  end

  #Method for building a dataset from the given file
  #the dataset is stored in the 2 dimensional array
  #first dimension is the index of tuples
  #second dimension is the index of attributes
  #att_names contains the first line of the file, which has to be the attribute names
  #att_types contains the second line of the file, which has to be the attribute types

  def build_dataset path
    file = File.new(path, "r")
    i=0
    while (line = file.gets)
       line = line.strip
       unless line.empty?       
         if i == 2
           @dataset.push(line.split(","))
         elsif 0 == i
           @att_names = line.split(",")
           i += 1
         else
           @att_types = line.split(",")
           i += 1
         end
       end
    end
  end

  #returns the size_of a dataset 
  def get_dataset_size
    @dataset.size
  end

  #returns the size of a tuple (number of attributes)
  def get_tuple_size
    @dataset[0].size
  end

  def get_norm_const attribute_name
    min_value = nil
    max_value = nil
    tuple_index = @att_names.index(attribute_name)

    @dataset.each do |item|
      i = Float item[tuple_index]
     
      if  (min_value == nil || min_value > i )
        min_value = i       
      end

      if (max_value == nil || max_value < i )
        max_value = i
      end
    end    
    norm_constant = max_value - min_value
    return norm_constant
  end
end
