class Solution < ActiveRecord::Base
	
	#Validations
	validates :code, presence: true

	#Relations
	belongs_to :student
	belongs_to :problem

	#Methods
	# [Compiler: Validate - Story 3.5]
	# Checks the validity of a submitted solution
	# and show the runtime and logic errors if exist
	# Parameters:
	# 	solution: the solution to be validated
	#   testcases: the testcases that will test the submitted code
	# Returns: a hash response containing status for the solution,
	#		   solution errors or success message.
	# Author: MOHAMEDSAEED
	def self.validate(solution, test_cases)
		response = []
		compiler_status = Compiler.compiler_feedback(solution)
		if compiler_status[:success]
			test_cases.each do |testcase|
				input = testcase.input
				expected_output = testcase.output
				runtime_check = Executer.execute(solution, input)
				if(runtime_check[:executer_feedback])
					output = runtime_check[:executer_output][:message]
					if (output != expected_output)
						if(output.to_s.empty?)
							output = "Empty"
						end
						response << {success: false, test_case: input, 
							response: "Logic error: Expected output: " +
							expected_output.to_s.strip + ", but your output was: " + output}
						unless solution.status == 4
							solution.status = 5
						end
					else
						response << {success: true, test_case: input, 
							response: "Passed!"}
						unless solution.status == 4 | 5
							solution.status = 1
						end
					end
				else
					runtime_error = runtime_check[:executer_output]
					explanation = get_response(runtime_error)
					solution.status = 4
					response << {success: false, test_case: input, 
							response: "Runtime error: " + explanation}
				end
			end
		else
			return {compiler_error: true, compiler_output: compiler_status}
		end
		solution.save
		return response
	end

	# [Compiler: Validate - Story 3.5]
	# outputs the runtime error with a more descriptive error message
	# Parameters:
	# 	error: the original runtime error
	# Returns: a String with the explained runtime error
	# Author: MOHAMEDSAEED
	def self.get_response(error)
		if error[:errors].include?("/ by zero")
			return "Division by zero, for example: a/b, b = 0"
		elsif error[:errors].include?("ArrayIndexOutOfBounds")
			return "Index is out of array range"
		elsif error[:errors].include?("StringIndexOutOfBounds")
			return "Index is out of string range"
		elsif  error[:errors].include?("ClassCastException")
			return "Wrong type casting"
		elsif error[:errors].include?("NullPointerException")
			return "Trying to access a null object"
		elsif  error[:errors].include?("IOException")
			return "Error when trying to read or write data"
		elsif  error[:errors].include?("NumberFormatException")
			return "Invalid string to be converted to number"
		elsif  error[:errors].include?("StackOverflowError")
			return "Calling a recursion function that never ends"
		else
			return error[:errors]
		end
	end

	# [Compiler: Validate - Story 3.5]
	# Parameters:
	# 	s_id : the id of the current Student
	# 	p_id : the id of the current Problem
	# Returns: the number of trials the student made for this problem
	# Author: MOHAMEDSAEED
	def self.get_num_of_trials(s_id, p_id)
		num_of_trials = Solution.distinct.count(:all,
						:conditions => ["student_id = ? AND problem_id = ? AND status != ?",
						s_id, p_id, 3])
	end

	# [
	#	Compiler: Compile - Story 3.4
	# 	Compiler: Validate - Story 3.5
	# 	Debugger: Debug - Story 3.6
	# 	Compiler: Test - Story 3.15
	# ]
	# Returns the file name associated with this solution code.
	# Parameters:
	# 	none
	# Returns: The solution's java file name
	# Author: Rami Khalil
	def file_name
		return 'st' + student_id.to_s + 'pr' + problem_id.to_s + 'so' + id.to_s
	end

	# [
	#	Compiler: Compile - Story 3.4
	# 	Compiler: Validate - Story 3.5
	# 	Debugger: Debug - Story 3.6
	# 	Compiler: Test - Story 3.15
	# ]
	# Returns the java file name associated with this solution code.
	# Parameters:
	#	prepend_path: A boolean value deciding whether the java file folder path should be prepended.
	# 	append_extension: A boolean value deciding whether the file extension should be appended.
	# Returns: The solution's java file name
	# Author: Rami Khalil
	def java_file_name(prepend_path = false, append_extension = false)
		jfile_name = file_name
		jfile_name += ".java" if append_extension
		jfile_name = JAVA_PATH + jfile_name if prepend_path
		return jfile_name
	end

	# [
	#	Compiler: Compile - Story 3.4
	# 	Compiler: Validate - Story 3.5
	# 	Debugger: Debug - Story 3.6
	# 	Compiler: Test - Story 3.15
	# ]
	# Returns the class file name associated with this solution code.
	# Parameters:
	#	prepend_path: A boolean value deciding whether the java file folder path should be prepended.
	# 	append_extension: A boolean value deciding whether the file extension should be appended.
	# Returns: The solution's class file name
	# Author: Rami Khalil
	def class_file_name(prepend_path = false, append_extension = false)
		jfile_name = file_name
		jfile_name += ".class" if append_extension
		jfile_name = CLASS_PATH + jfile_name if prepend_path
		return jfile_name
	end

	# [Compiler: Compile - Story 3.4]
	# Returns the folder's name, which the solution's files will be placed into.
	# Parameters: none
	# Returns:
	#	The folder's name.
	# Author: Ahmed Moataz
	def folder_name
		return 'st' + student_id.to_s + 'pr' + problem_id.to_s + 'so' + id.to_s + '/'
	end

	# [Compiler: Compile - Story 3.4]
	# Returns the file path of the soltion's files.
	# Parameters:
	#	append_extension: A boolean value indicating if the file extension
	#		should be appended or not.
	# Returns: 
	#	path: The file path.
	# Author: Ahmed Moataz
	def file_path(append_extension = true)
		path =  SOLUTION_PATH + folder_name + class_name
		path += '.java' if append_extension
		return path
	end

	#Constants
	STATUS_SUBMITTED	= 	0
	STATUS_ACCEPTED		=	1
	STATUS_COMPILED_WITH_ERRORS		=	2
	STATUS_COMPILED_WITHOUT_ERRORS		= 	3
	STATUS_EXECUTED_WITH_RUNTIME_ERRORS	=	4
	STATUS_EXECUTED_WITH_LOGIC_ERRORS	=	5
	JAVA_PATH	=	'students_solutions/Java/'
	CLASS_PATH	=	'students_solutions/Class/'
	SOLUTION_PATH = 'students_solutions/'

end