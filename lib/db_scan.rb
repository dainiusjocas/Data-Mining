require 'lib/dataset'

class Dbscan

 #constructor
  def initialize dataset
    @clustered_dataset = Hash.new
    @working_dataset = dataset
  end

 #method returns cluster no of tuple
  def get_cluster_nr_of_tuple tuple
    return @clustered_dataset[tuple]
  end

 #method sets cluster no to tuple
  def set_cluster_nr_of_tuple tuple,number
     @clustered_dataset[tuple] = number
  end

 #method prepare dataset
  def prepare_dataset
    @working_dataset.dataset.each do |tuple|
      set_cluster_nr_of_tuple tuple,-1
    end
  end

 #this method clusterize dataset
  def clusterize epsilion,min_number_of_points
    prepare_dataset
    cluster_id=1
    @working_dataset.dataset.each do |tuple|
      if (get_cluster_nr_of_tuple(tuple)==-1)
        if expand_cluster tuple,cluster_id,epsilion,min_number_of_points
          cluster_id=cluster_id+1
        end
      end
    end
    return @clustered_dataset
  end

 #this method queries tuple neighborhood from dataset
  def region_query tuple,epsilion
    result = Array.new
    @working_dataset.dataset.each do |loop_tuple|
 	      if   (@working_dataset.get_minkovski_distance_between_tuples(tuple,loop_tuple)) < epsilion
					result.push loop_tuple
        end
    end
 	  return result
   end

#this method sets cluster no to tuple set
  def change_cluster_id tuples,cluster_id
			tuples.each do |tuple|
				set_cluster_nr_of_tuple tuple,cluster_id
      end
  end

#this method checks if tuple can create to cluster and expand neighborhood
  def expand_cluster tuple,cluster_id,epsilion,min_points
    seeds = region_query tuple,epsilion
		if (seeds.size < min_points)
      set_cluster_nr_of_tuple tuple,0
      return false
    else
      change_cluster_id seeds,cluster_id
      seeds.delete(tuple)
			while seeds.size!=0
        current_tuple = seeds.first
				result = region_query current_tuple,epsilion
				if result.size>=min_points
          result.each do |result_tuple|
            if (get_cluster_nr_of_tuple result_tuple) ==0 || (get_cluster_nr_of_tuple result_tuple)==-1
              if (get_cluster_nr_of_tuple result_tuple)==-1
                seeds.push result_tuple
              end
							set_cluster_nr_of_tuple result_tuple,cluster_id
            end
          end
        end
			  seeds.delete(current_tuple)
       end
    end
   	return true
  end

# This method outputs clusterized array to file
  def cluster_and_write_clustered_dataset_to_file file_name, epsilion,min_number_of_points
    start_time = Time.new
    result = clusterize epsilion,min_number_of_points
    duration = Time.new - start_time
    File.open(file_name, 'w') {|f|

      attribute_types = ""
      attribute_names = ""
      @working_dataset.names_and_types_of_attributes.each {|attribute_name, attribute_type|
        attribute_names << "#{attribute_name},"
        attribute_types << "#{attribute_type},"
      }
      f.puts attribute_names.chop
      f.puts attribute_types.chop

      temp_string = ""
      ordered_result = result.sort{|a,b| a[1]<=>b[1]}
      ordered_result.each { |item|
        item[0].each { |attribute|
          temp_string << attribute << ','
        }
        f.puts "#{temp_string}#{item[1]}"
        temp_string = ""
      }

      result_hash = Hash.new
      ordered_result.each {|rez|
        if result_hash.has_key?(rez[1])
          result_hash[rez[1]] = result_hash[rez[1]] +1
        else
          result_hash[rez[1]] = 1
        end
      }

      f.puts
      result_hash.each { |key, value| f.puts "Cluster number #{key} has #{value} elements"}

      f.puts
      f.puts "Duration of execution of algorithm was #{duration} seconds"


#      result.each { |key,value|
#        key.each{ |attribute| temp_string << "#{attribute}," }
#        f.puts("#{temp_string}#{value}")
#        temp_string = ""
#      }
    }
  end

end