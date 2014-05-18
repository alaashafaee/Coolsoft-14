require "open3"
require "fileutils"
require 'pty'
class Debugger

	# [Debugger: Debug - Story 3.6]
	# Gets the output from the output stream of the debugger
	# 	until the passed regex is encountered
	# Parameters:
	# 	regex : The input regex to be encountered to return
	# Returns: A String of the buffer
	# Author: Rami Khalil
	def buffer_until(regex, readchar = false)
		buffer = ""
		TimeLimit.start(0.5){
			bool = false
			unless $wait_thread.nil?
				bool = !$wait_thread.alive?
			end
			until regex.any? { |expression| buffer =~ expression } or bool do
				begin
					if readchar
						temp = $output.readchar
					else
						temp = $output.read_nonblock 2048
					end
					buffer += temp
				rescue
				end
				unless $wait_thread.nil?
					bool = !$wait_thread.alive?
				end
			end
		}
		check_termination buffer
		return buffer
	end

	# [Debugger: Debug - Story 3.6]
	# Inputs an input to the input stream of the debugger
	# Parameters:
	# 	input : The input to be written in the sub stream
	# Returns: none
	# Author: Rami Khalil
	def input(input)
		$input.puts input
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
				input $step
				nums = get_line
				locals = []
				stack = []
				begin
					locals = get_variables
					stack = get_stack_trace
				rescue => e
				end
				nums[:locals] = locals
				nums[:stack] = stack
				$all << nums
				counter += 1
			rescue => e
				$input.close
				raise 'Exited'
			end
		end
	end

	# [Debugger: Debug Python - Story X.8]
	# Checks if the line contains a line that 
	# 	indicates the program has stopped debugging
	# Parameters:
	# 	line: The line to be checked
	# Returns: True if there is a stop string otherwise false
	# Author: Mussab ElDash
	def check_termination(line)
		if line =~ $TERM
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
	def self.debug(solution, input)
		folder_name = Solution::SOLUTION_PATH + solution.folder_name
		debugging = ""
		status = ""
		Dir.chdir(folder_name){
			debugging, status = $debugger.start($class_name, input.split(" "))
		}
		FileUtils.rm_rf(folder_name)
		unless status
			status = "An Error occured."
		end
		return {:success => true, data: debugging, status: status}
	end
end
