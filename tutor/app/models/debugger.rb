require "open3"
class Debugger < ActiveRecord::Base
	
	#Validations

	#Relations
	
	#Scoops
	
	#Methods

	def get_variables
		method_arguments = []
		local_variables = []
		instance_variables = []
		flag = 0
		input "locals"
		output_buffer = bufferUntilComplete
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
				method_arguments << variable_value
			else
				local_variables << variable_value
		end
	end

end