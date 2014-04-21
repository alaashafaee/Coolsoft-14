require "open3"
class Debugger < ActiveRecord::Base
	
	#Validations

	#Relations
	
	#Scoops
	
	#Methods
	# [Debugger: Debug - Story 3.6]
	# Gets the output from the output stream of the debugger
	# 	untill the passed regex is encountered
	# Parameters:
	# 	regex : The input regex to be encountered to return
	# Returns: A String of the buffer
	# Author: Rami Khalil
	def bufferUntil regex
		buffer = ""
		until !$wait_thread.alive? or regex.any? { |expression| buffer =~ expression } do
			begin
				temp = $output.read_nonblock 2048
				buffer += temp
			rescue
			end
		end
	  	return buffer
	end

	# [Debugger: Debug - Story 3.6]
	# Gets the output from the output stream of the debugger
	# 	untill the below regex is encountered
	# Parameters: None
	# Returns: A String of the buffer
	# Author: Rami Khalil
	def bufferUntilReady
		(bufferUntil [/> $/m]) + "\n"
	end

	# [Debugger: Debug - Story 3.6]
	# Gets the output from the output stream of the debugger
	# 	untill the below regex is encountered
	# Parameters: None
	# Returns: A String of the buffer
	# Author: Rami Khalil
	def bufferUntilComplete
		(bufferUntil [/\[\d\] $/m]) + "\n"
	end
	
	# [Debugger: Debug - Story 3.6]
	# Inputs an input to the input stream of the debugger JDB
	# Parameters:
	# 	input : The input to be written in the sub stream
	# Returns: None
	# Author: Rami Khalil
	def input input
		$input.puts input
	end

	# [Debugger: Debug - Story 3.6]
	# Starts the debugging session and return all variables and there values
	# 	100 steps ahead
	# Parameters:
	# 	file_path : The path of the file to debugged
	# 	input : The arguments to be passed to the main method
	# Returns: A List of all 100 steps ahead
	# Author: Mussab ElDash
	def start(file_path, input)
		to_be_compiled = file_path
		if file_path =~ /.*\.java/
			file_path = file_path[0..-6]
		else
			to_be_compiled = file_path + ".java"
		end
		if !system("javac -g " + to_be_compiled)
			puts "Compilation Error"
			exit
		end
		$All = []
		begin
			$input, $output, $error, $wait_thread = Open3.popen3("jdb",file_path_with_args.strip)
			bufferUntilReady
			input "stop in #{file_path}.main"
			bufferUntilReady
			num = get_line
			locals = get_variables
			hash = {:line => num, :locals => locals}
			$All << hash
			debug
		rescue => e
			p e.message
		end
		return $All
	end
	
	# [Debugger: Debug - Story 3.6]
	# Iterates 100 times to get the value of all local variables in each step
	# Parameters: None
	# Returns: None
	# Author: Mussab ElDash
	def debug
		counter = 0
		while counter < 100 && !$input.closed? do
			begin
				num = get_line
				locals = get_variables
				hash = {:line => num, :locals => locals}
				$All << hash
				counter += 1
			rescue => e
				puts e.message
				$input.close
				puts "closed"
			end
		end
	end
	
	# [Debugger: Debug - Story 3.6]
	# Gets the number of the line to be executed
	# Parameters: None
	# Returns: The number of the line to be executed
	# Author: Mussab ElDash
	def get_line
		input "step"
		out_stream = bufferUntilComplete
		list_of_lines = out_stream.split(/\n+/)
		last_line = list_of_lines[-2]
		/\d+/=~ last_line
		regex_capture = $&
		return regex_capture.to_i
	end

end
