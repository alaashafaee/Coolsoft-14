require "open3"
require "fileutils"
class Debugger

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
	# Inputs an input to the input stream of the debugger JDB
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
				begin
					locals = get_variables
				rescue => e
				end
				nums[:locals] = locals
				$all << nums
				counter += 1
			rescue => e
				$input.close
				raise 'Exited'
			end
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
		class_name = solution.class_name
		folder_name = Solution::SOLUTION_PATH + solution.folder_name
		debugging = ""
		status = ""
		Dir.chdir(folder_name){
			debugging, status = $debugger.start(class_name, input.split(" "))
		}
		FileUtils.rm_rf(folder_name)
		return {:success => true, data: debugging, status: status}
	end
end