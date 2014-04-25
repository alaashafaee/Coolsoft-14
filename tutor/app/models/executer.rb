class Executer

	# [Compiler: Test - Story 3.15]
	# Runs the solution submitted on the submitted test case
	# Parameters:
	#	file_name: The submitted file name
	# 	input: Test case entered by the user
	# Returns:
	# 	@execute_res: The execution result
	# Author: Ahmed Akram
	def self.execute(file_name, input, problem_id)
		class_path = Solution::CLASS_PATH
		validity = check_input_validity(input, problem_id)
		if validity[:status]
			@execute_res = %x[#{'java -cp ' + class_path + ' ' + file_name + ' ' + input + ' 2>&1'}]
			puts @execute_res
			if @execute_res.include?("Exception")
				return false
			else
				return true
			end
		else
			@execute_res = validity[:msg]
			return false
		end
	end

	# [Compiler: Test - Story 3.15]
	# This method checks that the test case entered by the user is a valid one
	# Parameters:
	#	input: Test case entered by the user
	# 	problem_id: id of the problem being solved
	# Returns:
	# 	A hash [status, msg], where status is true or false and msg is costume explaining message
	# Author: Ahmed Akram
	def self.check_input_validity(input, problem_id)
		variables_number = Problem.find_by_id(problem_id).test_cases.first.input.split(" ").count
		if input.include?("\n")
			return {status: false, msg: "Input can not have line breaks \"don't use enter\""}
		end
		if input.split(" ").count != variables_number
			msg = "Enter only " + variables_number.to_s + " numbers"
			return {status: false, msg: msg}
		end
		return {status: true, msg: nil}
	end

	# [Compiler: Test - Story 3.15]
	# Replaces the class name from the error with a costume one
	# Parameters:
	#	file_name: The submitted file name
	# 	error: The runtime error
	# 	sub_name: The costume name to replace the class name
	# Returns:
	# 	none
	# Author: Ahmed Akram
	def self.remove_class_name(file_name, error, sub_name)
		return error.gsub(file_name, sub_name)
	end

	# [Compiler: Test - Story 3.15]
	# Returns the runtime error and a message
	# Parameters:
	#	file_name: The submitted file name
	# 	sub_name: The name to replace the class name
	# Returns:
	# 	A hash [error, explanation], where error is the runtime error and explanation
	# 		is a custom message to explain the error
	# Author: Ahmed Akram
	def self.get_runtime_error(file_name, sub_name)
		@execute_res = remove_class_name(file_name, @execute_res, sub_name)

		if @execute_res.include?("/ by zero")
			message = "Division by Zero results in infinity, "\
						"which computers can not understand. Be careful !"
			return msg = {error: @execute_res, explanation: message}
		else
			message = "To be set Runtime Error!"
			return msg = {error: @execute_res, explanation: message}
		end
	end

	# [Debugger: Debug - Story 3.6]
	# Returns a message explaining what this error is
	# Parameters:
	#	exception: The exception to be explained
	# Returns: The Explanation of the exception given
	# Author: Mussab ElDash
	def self.get_runtime_explaination(exception)
		if exception.include?("/ by zero") || exception.include?("ArithmeticException")
			message = "Division by Zero results in infinity, " +
				"which computers can not understand. Be careful !"
			return {error: exception, explanation: message}
		else
			message = "To be set Runtime Error!"
			return {error: exception, explanation: message}
		end
	end

	# [Compiler: Test - Story 3.15]
	# Returns the output for the test case in case it ran successfully
	# Parameters:
	#	none
	# Returns:
	# 	@execute_res: The answer to the test case
	# Author: Ahmed Akram
	def self.get_output
		return @execute_res
	end

end
