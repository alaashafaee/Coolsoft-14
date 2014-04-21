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
		return method_arguments + local_variables + instance_variables
	end

	def get_instance_variables
		input "dump this"
	end

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

	def get_name variable
		name = variable.split(" = ").first
		return name
	end

end