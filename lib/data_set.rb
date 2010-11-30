# To change this template, choose Tools | Templates
# and open the template in the editor.

class Dataset
  attr_accessor :dataset, :tuple

  def initialize
    @dataset = Array.new
    @tuple = Array.new
  end

  def build_dataset path

    file = File.new(path, "r")
    while (line = file.gets)
      if !line.start_with?("@")
        @tuple.push(line.split(","))
      end
      puts @tuple.last
    end
  end

end
