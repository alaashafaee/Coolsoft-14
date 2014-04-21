require "open3"
class Debugger < ActiveRecord::Base
	
	#Validations

	#Relations
	
	#Scoops
	
	#Methods

	def get_variables
		method_arguments = []
		local_variables = []
		instance_variables = get_instance_variables
		flag = 0
		input "locals"
		output_buffer = buffer_until_complete
		output_buffer.each_line do |line|
			if line == "Method arguments:"
				flag = 1
				next
			else
				flag = 2
				next
			end
			variable_value = get_value line
			if flag == 1
				method_arguments = method_arguments + variable_value
			else
				local_variables = local_variables + variable_value
		end
		return method_arguments + local_variables + instance_variables
	end

	def get_value variable
		result = []
		if variable.match("instance")
			variable_name = get_name variable
			input "dump " + variable_name
			output_buffer = buffer_until_complete
			result << variable
			input "print " + variable_name
			output_buffer = buffer_until_complete
			result << variable
		else
			result << variable
		end
		return result
	end

end