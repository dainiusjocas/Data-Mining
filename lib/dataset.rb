# To change this template, choose Tools | Templates
# and open the template in the editor.

class Dataset
  attr_accessor :dataset, :tuple

  def initialize
    @dataset = Array.new
  end

  def build_dataset path

    file = File.new(path, "r")
    while (line = file.gets)
      line.strip
      if !line.start_with?("@") && line.length>0
        @dataset.push(line.split(","))
      end
    end
    puts @dataset
  end

  def get_size
    return @dataset.size
  end
end
