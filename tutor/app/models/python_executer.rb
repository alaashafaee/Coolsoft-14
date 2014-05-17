class PythonExecuter < Executer

	# [Run Python Code - Story X.5]
	# Runs the solution submitted on the submitted test case
	# Parameters:
	#	sol: The created solution
	# 	input: Test case entered by the user
	# Returns:
	# 	$execute_res: The execution result
	# Author: Ahmed Akram
	def execute(sol, input)
		$lang = 'python '
		$error = 'Error'
		$extension = '.py'
		$stream = ' 2>&1'
		return super
	end

	# [Run Python Code - Story X.5]
	# Returns a message explaining what this error is
	# Parameters:
	#	exception: The exception to be explained
	# Returns: The Explanation of the exception given
	# Author: Ahmed Akram
	def get_runtime_explaination(exception)
		return PythonExecuter.get_runtime_explaination(exception)
	end

	# [Run Python Code - Story X.5]
	# Returns a message explaining what this error is
	# Parameters:
	#	exception: The exception to be explained
	# Returns: The Explanation of the exception given
	# Author: Ahmed Akram
	def self.get_runtime_explaination(exception)
		if exception.include?("ZeroDivisionError") || exception.include?("ArithmeticException")
			message = "Division by Zero results in infinity, " +
				"which computers can not understand. Be careful !"
			return {errors: exception, explanation: message}
		else
			message = "To be set Runtime Error!"
			return {errors: exception, explanation: message}
		end
	end

end