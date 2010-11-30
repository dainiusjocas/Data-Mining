

class Dataset
  i=0
  tuple[]

  def read_file path
    file = File.new("#{path}", "r")
  end

  def build_dataset
    while (line = file.gets)
      i++
      if !line.start_with?("@")
       tuple[i] = line.to_s
      end
    end
  end
end


Dataset.read_file "auto_mpg.arff"
Dataset.build_dataset

