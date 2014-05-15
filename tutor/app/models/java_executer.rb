class JavaExecuter

	# [Compiler: Test - Story 3.15]
	# Runs the solution submitted on the submitted test case
	# Parameters:
	#	sol: The created solution
	# 	input: Test case entered by the user
	# Returns:
	# 	@execute_res: The execution result
	# Author: Ahmed Akram
	def self.execute(sol, input)
		@solution = sol
		file_name = @solution.class_name
		folder_name = @solution.folder_name
		validity = check_input_validity(input, @solution.problem.id)
		if validity[:status]
			echo_input = 'echo ' + '\'' + input + '\'' + ' | '
			Dir.chdir(Solution::SOLUTION_PATH + folder_name) {
				@execute_res = %x[#{echo_input + 'java '+ file_name}]
			}
			if @execute_res.include?("Exception")
				return {executer_feedback: false, executer_output: get_runtime_error()}
			else
				return {executer_feedback: true, executer_output: get_output()}
			end
		else
			return {executer_feedback: false, executer_output: validity[:msg]}
		end
	end

	# [Compiler: Test - Story 3.15]
	# Creates a new solution with the passed parameters
	# Parameters:
	#	student_id: The solver id
	#	problem_id: The problem id
	#	code: The submitted code
	# 	input: Test case entered by the user
	# Returns:
	# 	none
	# Author: Ahmed Akram
	def self.create_solution(student_id, problem_id, code, input)
		solution = Solution.create({code: code, student_id: student_id,
			problem_id: problem_id})
		compile_status = JavaCompiler.compiler_feedback(solution)
		unless compile_status[:success]
			return {compiler_error: true, compiler_output: compile_status}
		end
		return execute(solution, input)
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
<<<<<<< HEAD:tutor/app/models/java_executer.rb
		variables_number = Cproblem.find_by_id(problem_id).test_cases.first.input.split(" ").count
		# if input.include?("\n")
		# 	return {status: false, msg: "Input can not have line breaks \"don't use enter\""}
		# end
		# if input.split(" ").count != variables_number
		# 	msg = "Enter only " + variables_number.to_s + " numbers"
		# 	return {status: false, msg: msg}
		# end
=======
		variables_number = Problem.find_by_id(problem_id).test_cases.first.input.split(" ").count
		if input.split("\n").count != variables_number
			msg = "Enter only " + variables_number.to_s + " numbers"
			return {status: false, msg: msg}
		end
>>>>>>> e2afb8647e68a551f95d82ec672a396f2312812e:tutor/app/models/executer.rb
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
		execute_res = remove_class_name(file_name, execute_res, sub_name)
		return get_runtime_explaination(execute_res)
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
			return {errors: exception, explanation: message}
		else
			message = "To be set Runtime Error!"
			return {errors: exception, explanation: message}
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
	def self.get_runtime_error
		file_name = @solution.file_name
		sub_name = 'CoolSoft'
		@execute_res = remove_class_name(file_name, @execute_res, sub_name)
		return get_runtime_explaination @execute_res
	end

	# [Compiler: Test - Story 3.15]
	# Returns the output for the test case in case it ran successfully
	# Parameters:
	#	none
	# Returns:
	# 	@execute_res: The answer to the test case
	# Author: Ahmed Akram
	def self.get_output
		return {success: true, message: @execute_res}
	end

end
