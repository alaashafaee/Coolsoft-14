class JavaExecuter < Executer

	# [Compiler: Test - Story 3.15]
	# Runs the solution submitted on the submitted test case
	# Parameters:
	#	sol: The created solution
	# 	input: Test case entered by the user
	# Returns:
	# 	$execute_res: The execution result
	# Author: Ahmed Akram
	def execute(sol, input)
		$lang = 'java '
		$error = 'Exception'
		$extension = ''
		$stream = ' 2>&1'
		return super
	end

	def get_runtime_explaination(exception)
		return JavaExecuter.get_runtime_explaination(exception)
	end

	# [Debugger: Debug - Story 3.6]
	# Returns a message explaining what this error is
	# Parameters:
	#	exception: The exception to be explained
	# Returns: The Explanation of the exception given
	# Author: Ahmed Akram
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

end