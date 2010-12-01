#Dataset class stores the dataset generated from the datafile
#datafile must contain a header: first line - attribute names
# =>                             second line - attribute types
#datafile must be a comma separated values file

class Dataset
  attr_accessor :dataset, :n, :m, :att_names, :att_types

  #constructor of the class, initializing the class variables
  def initialize
    @dataset = Array.new
    @att_names = Array.new
    @att_types = Array.new
    @n = 0
    @m = 0
  end

  #Method for building a dataset from the given file
  #the dataset is stored in the 2 dimensional array
  #first dimension is the index of tuples
  #second dimension is the index of attributes
  #att_names contains the first line of the file, which has to be the attribute names
  #att_types contains the second line of the file, which has to be the attribute types

  def build_dataset path
    file = File.new(path, "r")

    
    while (line = file.gets)
       line = line.strip
       unless line.empty?
        @dataset.push(line.split(","))
       end
    end

    @att_names = @dataset[0] #creates an array of attribute names
    @att_types = @dataset[1] #creates an array of attribute types
    n=@dataset.size
    @dataset = @dataset[2...n] #creates an 2-dimensional array of a dataset
   
  end

  #returns the size_of a dataset or a number of attributes in a data tuple
  def get_size size_of
    d_size = case size_of
    when 'line' then @dataset[0].size
    when 'dataset' then @dataset.size
    end
  end

  def get_attribute tuple, attribute
    puts @att_names[attribute]
    puts @att_types[attribute]
    puts @dataset[tuple][attribute]
  end
end
