class Executer

	# [Run Python Code - Story X.5]
	# Runs the solution submitted on the submitted test case
	# Parameters:
	#	sol: The created solution
	# 	input: Test case entered by the user
	# Returns:
	# 	$execute_res: The execution result
	# Author: Ahmed Akram
	def execute(sol, input)
		$solution = sol
		file_name = $solution.class_name
		folder_name = $solution.folder_name
		problem_type = sol.problem_type
		# validity = check_input_validity(input, $solution.problem.id, problem_type)
		# if validity[:status]
			Dir.chdir(Solution::SOLUTION_PATH + folder_name) {
				echo_input = 'echo ' + '\'' + input + '\'' + ' | '
				$execute_res = %x[#{echo_input + $lang + ' ' + file_name + $extension + $stream}]
			}
			if $execute_res.include?($error)
				return {executer_feedback: false, executer_output: get_runtime_error()}
			else
				return {executer_feedback: true, executer_output: get_output()}
			end
		# else
			# return {executer_feedback: false, executer_output: validity[:msg]}
		# end
	end

	# [Compiler: Test - Story 3.15]
	# This method checks that the test case entered by the user is a valid one
	# Parameters:
	#	input: Test case entered by the user
	# 	problem_id: id of the problem being solved
	# Returns:
	# 	A hash [status, msg], where status is true or false and msg is costume explaining message
	# Author: Ahmed Akram
	def check_input_validity(input, problem_id, problem_type)
		test_cases = get_test_cases(problem_id, problem_type)
		variables_number = test_cases.first.input.split("\n").count
		if input.split("\n").count != variables_number
			msg = "Enter only " + variables_number.to_s + " inputs"
			return {status: false, msg: msg}
		end
		return {status: true, msg: nil}
	end

	# [Run Python Code - Story X.5]
	# This method checks that the test case entered by the user is a valid one
	# Parameters:
	#	input: Test case entered by the user
	# 	problem_id: id of the problem being solved
	# 	problem_type: The type of the problem being solved
	# Returns:
	# 	A hash [status, msg], where status is true or false and msg is costume explaining message
	# Author: Ahmed Akram
	def get_test_cases(problem_id, problem_type)
		if problem_type == "Problem"
			return Problem.find_by_id(problem_id).test_cases
		elsif problem_type == "Cproblem"
			return Cproblem.find_by_id(problem_id).test_cases
		else
			return AssignmentProblem.find_by_id(problem_id).test_cases
		end
	end

	# [Compiler: Test - Story 3.15]
	# Returns the runtime error and a message
	# Parameters:
	#	file_name: The submitted file name
	# 	sub_name: The name to replace the class name
	# Returns: A hash [error, explanation], where error is the runtime error and explanation
	# 		is a custom message to explain the error
	# Author: Ahmed Akram
	def get_runtime_error
		return get_runtime_explaination $execute_res
	end

	# [Compiler: Test - Story 3.15]
	# Returns the output for the test case in case it ran successfully
	# Parameters: none
	# Returns:
	# 	$execute_res: The answer to the test case
	# Author: Ahmed Akram
	def get_output
		return {success: true, message: $execute_res}
	end

end