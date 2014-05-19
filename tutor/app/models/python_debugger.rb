class PythonDebugger < Debugger

	$buffer_regex = /(\(Pdb\) )*/

	# [Debugger: Debug Python - Story X.8]
	# Start python debugging
	# Parameters:
	# 	solution: The solution that has the information about the session
	# 	input: The arguments to be debugged against
	# Returns: The result of the debugging
	# Author: Mussab ElDash
	def self.debug(solution, input)
		$class_name = solution.class_name + ".py"
		$debugger = PythonDebugger.new
		return super
	end

	# [Debugger: Debug Python - Story X.8]
	# Starts the debugging session and return all variables and their values
	# 	100 steps ahead
	# Parameters:
	# 	file_path: The path of the file to debugged
	# 	input: The arguments to be passed to the main method
	# 	time: The time limit of the debugging session 
	# Returns: A List of all 100 steps ahead
	# Authors: Mussab ElDash + Rami Khalil
	def start(class_name, input, time = 30)
		$step = "next"
		$wait_thread = nil
		$TERM = /\(Pdb\) The program finished and will be restarted\r\n/m
		$regex = [/(\(Pdb\) )?.+->.+\r\n$/m]
		$all = []
		status = "The debugging session was successful."
		begin
			$output, slave = PTY.open
			master, $input = IO.pipe
			pid = spawn("python -m pdb #{class_name}", :in=>master, :out=>slave)
			master.close
			slave.close
			nums = get_line
			locals = get_variables
			nums[:locals] = locals
			$all << nums
			status = TimeLimit.start(time){
				debug
			}
		rescue => e
			unless e.message === 'Exited'
				return false
			end
		end
		begin
			Process.kill("INT", pid)
			Process.kill("INT", pid)
			Process.kill("INT", pid)
			Process.kill("TERM", pid)
		rescue => e
		end
		return $all, status
	end

	# [Debugger: Debug Python - Story X.8]
	# Gets the number of the line to be executed
	# Parameters: none
	# Returns: The number of the line to be executed
	# Author: Mussab ElDash
	def get_line
		out_stream = buffer_until $regex, true
		exceptions = has_exception out_stream
		name_string = $class_name.sub(/\.py/,"")
		/#{name_string}\.py\(\d+\).*\r\n/ =~ out_stream
		line_first_string = $&
		/\d+/ =~ line_first_string
		line_first = $&
		if line_first
			exceptions[:line] = line_first.to_i
			stream = get_stream out_stream, line_first.to_i
			if $all[-1]
				exceptions[:stream] = "#{$all[-1][:stream]}#{stream}"
			else
				exceptions[:stream] = stream
			end
			return exceptions
		else
			if exceptions[:exception]
				if $all[-1]
					$all[-1][:stream].sub(/#{exceptions[:exception]}$/m, "")
					$all[-1][:exception] = exceptions[:exception]
					$all[-1][:status] = false
				else
					first_step = exceptions[:exception]
					first_step =~ /, line \d+/
					second_step = $&
					third_step = second_step[7..-1]
					exceptions[:line] = third_step.to_i
				end
			end
			raise 'Exited'
		end
	end

	# [Debugger: Debug Python - Story X.8]
	# Checks if there is a runtime error thrown
	# Parameters:
	# 	line: The line to be checked if it has a runtime error
	# Returns: A hash of the exception and its explanation if exists
	# Author: Mussab ElDash
	def has_exception(line)
		if line.include? "> <string>(1)<module>()"
			exception = get_exception line
			return {:status => false, :exception => exception}
		end
		return {:status => true}
	end

	# [Debugger: Debug Python - Story X.8]
	# Gets the thrown exception
	# Parameters: none
	# Returns: The exception
	# Author: Mussab ElDash
	def get_exception(line)
		second_step = ""
		first_step = line.sub(/> <string>\(1\)<module>\(\)->None\r\n/m, "")
		second_step = first_step.sub(/.*\(Pdb\) /m, "")
		third_step = second_step.sub(/\-\-[A-Z][a-z]*\-\-\r\n/,"")
		return third_step
	end

	# [Debugger: Debug Python - Story X.8]
	# Checks if there is a runtime error thrown
	# Parameters:
	# 	line: The line to be checked if it has a runtime error
	# Returns: A hash of the exception and its explanation if exists
	# Author: Mussab ElDash
	def get_stream(line, num)
		name = $class_name.sub(/\.py/,"")
		regex = /(\-\-[A-Z][a-z]*\-\-\r\n)?> (\/[a-zA-Z0-9\-_]+)*\/#{name}\.py\(#{num}\).*\r\n$/m
		stream = line.sub(regex, "")
		regexp1 = /\(Pdb\) .*\(Pdb\) /m
		stream = stream.sub(regexp1, "")
		stream = stream.sub($buffer_regex, "")
		return stream
	end

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
		if name.starts_with? "'__"
			return false
		elsif value.include?("module") or value.include?("function") or value.include?("exception") \
			or value.include?("method") or value.include?("class")
			return false
		end
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
		input name[1..-2] + ".__dict__"
		output_buffer = buffer_until [/\{.*\}\r\n$/m], true
		output_buffer = output_buffer.sub($buffer_regex, "")
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
		output_buffer = buffer_until [/(\(Pdb\) )*.*\r\n/m], true
		output_buffer = output_buffer.sub($buffer_regex, "")
		output_buffer.each_line do |line|
			value << line
		end
		if value.match("instance")
			value = get_object_value name
		end
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
		output_buffer = buffer_until [/^(\(Pdb\) )*\[.*\]\r\n$/m], true
		# p output_buffer
		output_buffer = output_buffer.sub(/.*\(Pdb\) /m, "")
		output_buffer = output_buffer.sub($buffer_regex, "")
		output_buffer.each_line do |line|
			all_lines << line
		end
		all_lines_trimmed = all_lines[1..-4]
		list_of_variables = all_lines_trimmed.split(", ")
		list_of_variables.each do |variable|
			name = variable
			value = get_variable type, name
			if is_valid_variable name, value
				if type == "globals()"
					name = "global." + name
				end
				result << name + " = " + value
			end
		end
		return result
	end

	# [View Variables Python Code - Story X.8]
	# Fetches the variables found in the class and returns
	# 	a list of all variables in the class with their
	#	associated values. It uses the helper method
	# 	"get_variables_helper" which gets the set of variables
	# 	according to their scope.
	# Parameters: none
	# Returns:
	# 	An array. It contains the list of variables and their values
	# Author: Khaled Helmy
	def get_variables
		variables = []
		variables = get_variables_helper("locals()") + get_variables_helper("globals()")
		return variables
	end

	# [View Variables Python Code - Story X.8]
	# Fetches the stack trace of the code at the current state
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
		if false
			input "w"
			output_buffer = buffer_until [/.*>.*\r\n->.*\r\n$/m], true
			output_buffer = output_buffer.sub($buffer_regex, "")
			output_buffer = output_buffer[3..-3]
			output_buffer.each_line do |line|
				stack_trace << line
			end
		end
		return stack_trace
	end

end
