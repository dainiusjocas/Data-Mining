#!/usr/bin/env ruby

# This script waits for two parameters from command line:
# 1. input file. if you don't specify input file then script will crash!!!
# 2. output file. if you don't specify output file then output.txt will be used
#
# This script does:
# 0. read every line from input file
# 1. removes quotes
# 2. changes commas that were between quotes with spaces
# 3. changes string ", " with ","
# 4. changes string ",," with ",100,"
# 5. writes modified line to output file

input_file = File.new(ARGV[0], "r")

if (nil != ARGV[1])
  output_file = File.new(ARGV[1], "w+")
else
  output_file = File.new("output.txt", "w+")
end

line_nr = 0
while (line = input_file.gets)
  if line_nr > 1
    quotes = line.split("\"") # separate line by quote symbol

    if quotes[1] != nil
      without_comma = quotes[1].gsub(/,/,' ')
      # fill in default values for missing horsepower values
      temp = quotes[0].gsub!(/,,/, ',100,')
      quotes[0] = temp if temp != nil

      new_line = quotes[0] << without_comma
    end

    output_file.puts new_line
  else
    line.gsub!(/(, )/, ',') if line_nr == 1
    output_file.puts line
    line_nr += 1
  end
end

input_file.close
output_file.close

puts "Job succesful!"
