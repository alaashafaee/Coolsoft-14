require "open3"
class Debugger < ActiveRecord::Base
	
	#Validations

	#Relations
	
	#Scoops
	
	#Methods

	# [Debugger: View Variables - Story 3.7]
	# Fetches the variables found in the class and returns 
	# 	a list of all variables in the class with their 
	#	associated values
	# Parameters: None
	# Returns: 
	# 	An array. It contains the list of variables and their values
	# Author: Khaled Helmy
	def get_variables
		method_arguments = []
		local_variables = []
		class_variables = get_class_variables
		flag = 0
		input "locals"
		output_buffer = buffer_until_complete
		output_buffer.each_line do |line|
			if line == "Method arguments:"
				flag = 1
				next
			elsif line == "Local variables:"
				flag = 2
				next
			end
			if flag != 0
				variable_value = get_value line
				if flag == 1
					method_arguments = method_arguments + variable_value
				else
					local_variables = local_variables + variable_value
			end
		end
		return method_arguments + local_variables + class_variables
	end

	# [Debugger: View Variables - Story 3.7]
	# Return the list of instance and static variables of the
	# 	class from within static methods
	# Parameters: None
	# Returns: 
	# 	An array. It contains the list of instance and static
	# 	variables and their associated values
	# Author: Khaled Helmy
	def get_class_variables
		result = []
		input "print this.getClass().getName()"
		flag = 0
		output_buffer = buffer_until_complete
		output_buffer.each_line do |line|
			if flag == 1
				class_name = output_buffer.split(" = ").last
				input "fields " + class_name
				fields_list = buffer_until_complete
				fields_list.each_line do |line|
					if line.match("fields list")
						next
					else
						field_name = line.split(" ").last
						input "print this." + field_name
						field_result = buffer_until_complete
						field_result = field_result.split(".").last
						result << field_result
					end
				end
			else
				if line.match("Exception")
					break
				else
					flag = 1
			end
		end
		return result
	end

	# [Debugger: View Variables - Story 3.7]
	# Takes an object and evaluates its value
	# Parameters: 
	#   variable: a string containing an instance object
	# Returns: 
	# 	An array. It contains the values inside an object
	# Author: Khaled Helmy
	def get_value variable
		result = []
		if variable.match("instance")
			variable_name = get_name variable
			input "dump " + variable_name
			output_buffer1 = buffer_until_complete
			input "print " + variable_name
			output_buffer2 = buffer_until_complete
			result << output_buffer1
			if output_buffer1 != output_buffer2
				result << output_buffer2
		else
			result << variable
		end
		return result
	end

	# [Debugger: View Variables - Story 3.7]
	# Takes a line containing an object assignment and extracts
	# 	the object name
	# Parameters: 
	#   variable: A string containing an object assignment
	# Returns: 
	# 	A string. It contains the object name
	# Author: Khaled Helmy
	def get_name variable
		name = variable.split(" = ").first
		return name
	end

end