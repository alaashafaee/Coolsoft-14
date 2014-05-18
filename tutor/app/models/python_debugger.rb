class PythonDebugger < Debugger

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
		$step = "step"
		$wait_thread = nil
		$TERM = /\(Pdb\) The program finished and will be restarted\r\n/m
		$regex = [/(Pdb) .+ ->.+\r\n$/m]
		$all = []
		status = "The debugging session was successful."
		begin
			$output, slave = PTY.open
			master, $input = IO.pipe
			pid = spawn("python -m pdb #{class_name}", :in=>master, :out=>slave)
			master.close
			slave.close
			nums = get_line
			# locals = get_variables
			# nums[:locals] = locals
			nums[:locals] = []
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
		stream = stream.sub(/\(Pdb\) /, "")
		return stream
	end
end
