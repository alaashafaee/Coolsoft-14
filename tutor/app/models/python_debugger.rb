require "open3"
class PythonDebugger

	#Methods

	# [View Variables Python Code - Story X.8]
	# Checks if a variable is valid. A variable is valid if it is not
	# 	a module, a function or a reserved word.
	# Parameters:
	# 	name: a String containing the variable name.
	# 	value: a String containing the value of the variable.
	# Returns:
	# 	Boolean. It returns true if the variable is valid and
	# 		false otherwise.
	# Author: Khaled Helmy
	def is_valid_variable name, value
		if name.match("__")
			return false
		elsif value.match("module") or value.match("function")
			return false
		return true
	end

	# [View Variables Python Code - Story X.8]
	# Gets the instance variable values of an object.
	# Parameters:
	# 	name: a String containing the object name.
	# Returns:
	# 	String. It returns the values of the instance variables
	# 		in an object.
	# Author: Khaled Helmy
	def get_object_value name
		result = ""
		input name + ".__dict__"
		output_buffer = buffer_until_complete
		output_buffer.each_line do |line|
			result << line
		end
		return result
	end

	# [View Variables Python Code - Story X.8]
	# Evaluates the value of a variable according to its scope whether
	# 	it is a local variable or a global variable. It uses the helper
	# 	method "get_object_value" to evaluate the variable value if it
	# 	is an object.
	# Parameters:
	# 	type: a String containing the type of the variable. Either a local
	# 		variable or a global variable.
	# 	name: a String containing the name of the variable.
	# Returns:
	# 	String. It returns the evaluation of a certain variable.
	# Author: Khaled Helmy	
	def get_variable type, name
		value = ""
		input type + "[" + name + "]"
		output_buffer = buffer_until_complete
		output_buffer.each_line do |line|
			value << line
		end
		if value.match("instance")
			value = get_object_value name
		return value
	end

	# [View Variables Python Code - Story X.8]
	# Gets the list of variable names according to the scope whether
	# 	local or global and evaluates the value of each variable. It
	# 	uses the helper method "get_variable" to evaluate the value of
	# 	a given variable and "is_valid_variable" which checks if a variable
	# 	is valid.
	# Parameters:
	# 	type: a String containing the type of variables that need to be fetched.
	# 		The variables are local or global.
	# Returns:
	# 	An array. It contains the list of variables with their corresponding values
	# 		in the form of "name = value" according to their scope.
	# Author: Khaled Helmy
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
			if is_valid_variable name, value == true
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
