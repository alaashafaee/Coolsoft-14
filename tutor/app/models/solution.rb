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
	# 	problem_id: id of the problem being answered
	#   file: the name of the file which is compiled successfully
	#		  without errors
	# Returns: a hash response containing status for the solution,
	#		   solution errors or success message.
	# Author: MOHAMEDSAEED
	def self.validate(file, problem_id)
		response = {status: 0, success: [], runtime_error: [] ,runtime_error_exp: [] , logic_error: []}
		testcases = Problem.find_by_id(problem_id).test_cases
		testcases.each do |testcase| 
			input = testcase.input
			expected_output = testcase.output 
			runtime_check = Executer.execute(file, input, problem_id)
			if(runtime_check)
				output = Executer.get_output() 
				if (output != expected_output)
					response[:logic_error] << "Logic error: for input: " + input +" ,expected output: " + expected_output +" but your output was: " + output  
					unless response[:status] == 4
						response[:status] = 5
					end
				else
					unless(response[:status] == 4 | 5)
						response[:status] = 1 	
					end
				end
			else
				runtime_error = Executer.get_runtime_error(file, 'CoolSoft')
				runtime_error[:error] = "for input: " + input + " " + runtime_error[:error]
				response[:status] = 4
				response[:runtime_error] << runtime_error[:error]
				response[:runtime_error_exp] << runtime_error[:explanation]
			end
		end
		if response[:status] == 1
			response[:success] << "Your Solution is correct, Passed"
		end
		return response
	end

	# [Compiler: Validate - Story 3.5]
	# Parameters: 
	# 	s_id : the id of the current Student
	# 	p_id : the id of the current Problem
	# Returns: the number of trials the student made for this problem
	# Author: MOHAMEDSAEED
	def self.get_num_of_trials(s_id , p_id)
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
	# 	append_extension: A boolean value deciding whether the file extension should be appended.
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
	# 	append_extension: A boolean value deciding whether the file extension should be appended.
	# Returns: The solution's class file name
	# Author: Rami Khalil
	def class_file_name(prepend_path = false, append_extension = false)
		jfile_name = file_name
		jfile_name += ".class" if append_extension
		jfile_name = CLASS_PATH + jfile_name if prepend_path
		return jfile_name
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
	
end