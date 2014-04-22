require "open3"
class Debugger < ActiveRecord::Base
	
	#Validations

	#Relations
	
	#Scoops
	
	#Methods
	# [Debugger: Debug - Story 3.6]
	# Gets the output from the output stream of the debugger
	# 	until the passed regex is encountered
	# Parameters:
	# 	regex : The input regex to be encountered to return
	# Returns: A String of the buffer
	# Author: Rami Khalil
	def buffer_until(regex)
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
	# Inputs an input to the input stream of the debugger JDB
	# Parameters:
	# 	input : The input to be written in the sub stream
	# Returns: none
	# Author: Rami Khalil
	def input(input)
		$input.puts input
	end

	# [Debugger: Debug - Story 3.6]
	# Starts the debugging session and return all variables and their values
	# 	100 steps ahead
	# Parameters:
	# 	file_path : The path of the file to debugged
	# 	input : The arguments to be passed to the main method
	# Returns: A List of all 100 steps ahead
	# Authors: Mussab ElDash + Rami Khalil
	def start(class_name, input)
		$all = []
		Dir.chdir(Solution::CLASS_PATH){
			begin
				$input, $output, $error, $wait_thread = Open3.popen3("jdb", class_name, input)
				buffer_until_ready
				input "stop in #{class_name}.main"
				buffer_until_ready
				input "run"
				num = get_line
				# locals = get_variables
				hash = {:line => num, :locals => []}
				$all << hash
				debug
			rescue => e
				unless e.message === 'Exited'
					return false
				end
			end
		}
		return $all
	end

	# [Debugger: Debug - Story 3.6]
	# Iterates 100 times to get the value of all local variables in each step
	# Parameters: none
	# Returns: none
	# Author: Mussab ElDash
	def debug
		counter = 0
		while counter < 100 && !$input.closed? do
			begin
				input "step"
				num = get_line
				# locals = get_variables
				hash = {:line => num, :locals => []}
				$all << hash
				counter += 1
			rescue => e
				$input.close
				raise 'Exited'
			end
		end
	end

	# [Debugger: Debug - Story 3.6]
	# Gets the number of the line to be executed
	# Parameters: none
	# Returns: The number of the line to be executed
	# Author: Mussab ElDash
	def get_line
		out_stream = buffer_until_complete
		puts out_stream
		list_of_lines = out_stream.split(/\n+/)
		before_last_line = list_of_lines[-2]
		/, line=\d+/ =~ before_last_line
		before_last_regex_capture = $&
		/\d+/ =~ before_last_regex_capture
		before_last_regex_capture = $&
		last_line = list_of_lines[-2]
		/^\d+/=~ last_line
		last_regex_capture = $&
		if last_regex_capture
			return last_regex_capture.to_i
		elsif before_last_regex_capture
			return before_last_regex_capture.to_i
		else
			raise 'Exited'
		end
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
	def self.debug(student_id, problem_id, code, input)
		solution = Solution.create({code: code, student_id: student_id,
			problem_id: problem_id })
		compile_status = Compiler.compiler_feedback(solution)
		unless compile_status[:success]
			return {:success => false , data: compile_status}
		 end
		debugger = Debugger.new
		class_name = solution.class_file_name
		debugging = debugger.start(class_name, input)
		puts "-----------------------------------------------------"
		p debugging
		java_file = solution.java_file_name true, true
		class_file = solution.class_file_name true, true
		File.delete(java_file)
		File.delete(class_file)
		return {:success => true , data: debugging}
	end
end