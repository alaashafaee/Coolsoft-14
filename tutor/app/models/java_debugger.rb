class JavaDebugger < Debugger

	#Methods

	# [Debugger: Debug - Story 3.6]
	# Gets the output from the output stream of the debugger
	# 	until the below regex is encountered
	# Parameters: none
	# Returns: A String of the buffer
	# Author: Rami Khalil
	def buffer_until_ready
		(buffer_until [/> $/m]) + "\n"
	end

	# [Debugger: Debug - Story 3.6]
	# Gets the output from the output stream of the debugger
	# 	until the below regex is encountered
	# Parameters: none
	# Returns: A String of the buffer
	# Author: Rami Khalil
	def buffer_until_complete
		(buffer_until [/\[\d\] $/m]) + "\n"
	end

	# [Debugger: Debug - Story 3.6]
	# Starts the debugging session and return all variables and their values
	# 	100 steps ahead
	# Parameters:
	# 	file_path : The path of the file to debugged
	# 	input : The arguments to be passed to the main method
	# Returns: A List of all 100 steps ahead
	# Authors: Mussab ElDash + Rami Khalil
	def start(class_name, input, time = 30)
		$step = "step"
		$TERM = /\nThe application exited.*\n/
		$all = []
		$wait_thread = nil
		status = "The debugging session was successful."
		begin
			$input, $output, $error, $wait_thread = Open3.popen3("jdb", class_name, *input)
			buffer_until_ready
			input "stop in #{class_name}.main"
			buffer_until_ready
			input "run"
			nums = get_line
			locals = []
			locals = get_variables
			stack = get_stack_trace
			nums[:locals] = locals
			nums[:stack] = stack
			$all << nums
			status = TimeLimit.start(time) {
				debug
			}
		rescue => e
			unless e.message === 'Exited'
				return false
			end
		end
		begin
			Process.kill("TERM", $wait_thread.pid)
		rescue => e
		end
		return $all, status
	end

	# [Debugger: Debug - Story 3.6]
	# Gets the number of the line to be executed
	# Parameters: none
	# Returns: The number of the line to be executed
	# Author: Mussab ElDash
	def get_line
		out_stream = buffer_until_complete
		exceptions = has_exception out_stream
		stream = get_stream out_stream
		/,\sline=\d+/ =~ out_stream
		line_first = $&
		if line_first
			line_first = line_first[7..-1]
			exceptions[:line] = line_first.to_i
			if $all[-1]
				exceptions[:stream] = "#{$all[-1][:stream]}#{stream}"
			else
				exceptions[:stream] = ""
			end
			return exceptions
		else
			raise 'Exited'
		end
	end

	# [Debugger: Debug - Story 3.6]
	# Checks if there is a runtime error thrown
	# Parameters: 
	# 	line: The line to be checked if it has a runtime error
	# Returns: A hash of the exception and its explanation if exists
	# Author: Mussab ElDash
	def get_stream(line)
		/^>\s.+\n/ =~ line
		stream = $&
		if stream
			stream = stream[2..-1]
			p stream
			return stream
		end
		return ""
	end

	# [Debugger: Debug - Story 3.6]
	# Checks if there is a runtime error thrown
	# Parameters: 
	# 	line: The line to be checked if it has a runtime error
	# Returns: A hash of the exception and its explanation if exists
	# Author: Mussab ElDash
	def has_exception(line)
		/Exception occurred: / =~ line
		if $&
			exception = get_exception
			return {:status => false, :exception => JavaExecuter.get_runtime_explaination(exception)}
		end
		return {:status => true}
	end

	# [Debugger: Debug - Story 3.6]
	# Gets the thrown exception
	# Parameters: none
	# Returns: The exception
	# Author: Mussab ElDash
	def get_exception
		input "step"
		out_stream = buffer_until_complete
		ragex_first = /[[:space:]]+at\s[[:alnum:]]+\.main\([[:alnum:]]+\.java:\d+\)/m
		regex_second = /[[:space:]]+The application exited\n*/
		regex = /#{ragex_first}#{regex_second}/
		out_stream = out_stream.sub(regex, "")
		return out_stream
	end

	# [Debugger: Debug - Story 3.6]
	# Create a java file and start debugging
	# Parameters:
	# 	Student_id: The id of the current signed in student
	# 	problem_id: The id of the problem being solved
	# 	code: The code to be debugged
	# 	input: The arguments to be debugged against
	# Returns: The result of the debugging
	# Author: Mussab ElDash
	def self.debug(solution, input)
		$class_name = solution.class_name
		$debugger = JavaDebugger.new
		return super
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
			output_buffer1 = buffer_until_complete.split("main").first
			input "print " + variable_name
			output_buffer2 = buffer_until_complete.split("main").first
			unless output_buffer1.match("instance")
				result << "global." + output_buffer1
			end
			if output_buffer1 != output_buffer2
				unless output_buffer2.match("instance")
					result << "global." + output_buffer2
				end
			end
		else
			result << "global." + variable
		end
		return result
	end

	# [Debugger: View Variables - Story 3.7]
	# Return the list of instance and static variables of the
	# 	class from within static methods
	# Parameters: none
	# Returns:
	# 	An array. It contains the list of instance and static
	# 	variables and their associated values
	# Author: Khaled Helmy
	def get_class_variables
		result = []
		flag = 0
		input "print this.getClass().getName()"
		output_buffer = buffer_until_complete
		output_buffer.each_line do |line|
			if flag == 1
				class_name = output_buffer.split(" = ").last.split("main").first
				class_name = class_name[1..(class_name.size-3)]
				input "fields " << class_name
				fields_list = buffer_until_complete
				fields_list.each_line do |field|
					if field.match("fields list") or field.match("main")
						next
					else
						field_name = field.split(" ").last
						input "print this." + field_name
						field_result = buffer_until_complete
						field_result = field_result.split(".").last.split("main").first
						result << "global." + field_result
					end
				end
			else
				if line.match("Exception")
					break
				else
					flag = 1
				end
			end
		end
		return result
	end

	# [Debugger: View Variables - Story 3.7]
	# Fetches the variables found in the class and returns
	# 	a list of all variables in the class with their
	#	associated values
	# Parameters: none
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
			if line.match("Method arguments:")
				flag = 1
				next
			elsif line.match("Local variables:")
				flag = 2
				next
			elsif line.match("main")
				break
			end
			if flag != 0
				variable_value = get_value line
				if flag == 1
					method_arguments = method_arguments + variable_value
				else
					local_variables = local_variables + variable_value
				end
			end
		end
		return method_arguments + local_variables + class_variables
	end

	# [Debugger: View Variables - Story 3.7]
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
		input "where"
		output_buffer = buffer_until_complete
		output_buffer.each_line do |line|
			unless line == "main[1] \n"
				stack_trace << line
			end
		end
		return stack_trace
	end

end
