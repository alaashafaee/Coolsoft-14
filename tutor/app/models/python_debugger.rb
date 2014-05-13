require "open3"
class PythonDebugger

	#Methods

	def is_valid_variable name, value
		if name.match("__")
			return false
		elsif value.match("module") or value.match("function")
			return false
		return true
	end

	def get_object_value name
		result = ""
		input name + ".__dict__"
		output_buffer = buffer_until_complete
		output_buffer.each_line do |line|
			result << line
		end
		return result
	end

	def get_variable type, name
		value = ""
		input type + "[" + name + "]"
		output_buffer = buffer_until_complete
		output_buffer.each_line do |line|
			value << line
		end
		if is_valid_variable name, value == false
			return 0
		elsif value.match("instance")
			value = get_object_value name
		return value
	end

	def get_variables_helper type
		all_lines = ""
		result = []
		input type + ".keys()"
		output_buffer = buffer_until_complete
		output_buffer.each_line do |line|
			all_lines << line
		end
		all_lines_trimmed = all_lines[1..-2]
		list_of_variables = all_lines_trimmed.split(", ")
		list_of_variables.each do |variable|
			name = variable
			value = get_variable type, name
			unless value == 0
				result << name + " = " + value
			end
		end
		return result
	end

	# [View Variables Python Code - Story X.8]
	# Fetches the variables found in the class and returns
	# 	a list of all variables in the class with their
	#	associated values
	# Parameters: none
	# Returns:
	# 	An array. It contains the list of variables and their values
	# Author: Khaled Helmy
	def get_variables
		variables = []
		variables = get_variables_helper "locals()" + get_variables_helper "globals()"
		return variables
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
