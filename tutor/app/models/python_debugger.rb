require "open3"
class PythonDebugger

	#Methods

	# [View Variables Python Code - Story X.8]
	# Fetches the variables found in the class and returns
	# 	a list of all variables in the class with their
	#	associated values
	# Parameters: none
	# Returns:
	# 	An array. It contains the list of variables and their values
	# Author: Khaled Helmy
	def get_variables
		local_variables = []
		class_variables = get_class_variables
		input "dir()"
		output_buffer = buffer_until_complete
		output_buffer.each_line do |line|
			new_line = line[1..-2]
			list_of_variables = new_line.split(", ");
			local_variables << list_of_variables
		end
		return local_variables
	end

	# [View Variables Python Code - Story X.8]
	# Fetches the the stack trace of the code at the current state
	# 	where the call stack is examined which contains the list of
	# 	methods which did not finish its execution and thus did not
	# 	return yet
	# Parameters: none
	# Returns:
	# 	An array. It contains the list of methods in the call stack
	# 		which have not returned yet
	# Author: Khaled Helmy
	def get_stack_trace
		stack_trace = []
		input "w"
		output_buffer = buffer_until_complete
		output_buffer = output_buffer[3..-3]
		output_buffer.each_line do |line|
			stack_trace << line
		end
		return stack_trace
	end

end
