class Solution < ActiveRecord::Base
	
	#Validations
	validates :code, presence: true

	#Relations
	belongs_to :student
	belongs_to :problem


	
	
	#Scoops

	#Methods
	# [Compiler: Validate - Story 3.5]
	# checks the validity of a submitted solution  
	# and show the #compilation, runtime and logic errors if exist
	# Parameters: 
	# 	code: the code written in the editor from the form_for
	#   testcases: the testcases for the given problem 
	#   file: the name of the file which is compiled successfully
	#			without errors
	# Returns: a hash response containing status for the solution,
	# 			solution errors or success message.
	# Author: MOHAMEDSAEED
	def self.validate(code, testcases, file)
		response = {status: 0, success: [], failure: []}
		#compile_result = Compiler.compile(code)
		#if(compile_result[:sucess])
		testcases.each do |testcase| 
			input = testcase.input 
			expected_output = testcase.output
			runtime_check = Executer.execute(file , input)
			if(runtime_check)
				output = Executer.get_output() 
				if output != expected_output?
					response[:failure] << "Logic error: for input: " + input +" , 
					expected output: " + expected_output +" but your output was: "
					+ output  
					response[:status] = 5
				else
					response[:success] << "Your Solution is correct , Passed"
					response[:status] = 1 	
				end
			else
				runtime_error = Executer.get_runtime_error()
				response[:status] = 4
				response[:failure] << execute_message
			end
		end
		#else 
			#compile_message = Compiler.compileFeedback(compile_result)
			#response[:status] = 2
			#response[:failure] << compile_message 
		#end
		return response
	end

	# [Compiler: Validate - Story 3.5]
	# Parameters: 
	# 	s_id : the id of the current Student
	#   p_id : the id of the current Problem
	# Returns: the number of trials the student made for this problem
	# Author: MOHAMEDSAEED
	def self.get_num_of_trials(s_id , p_id)
		num_of_trials = Solution.distinct.count(:all,
						:conditions => [" student_id = ? AND problem_id = ? AND status != ? " ,
						s_id , p_id , 3])
	end

	#Constants
	STATUS_SUBMITTED	= 	0
	STATUS_ACCEPTED		=	1
	STATUS_COMPILED_WITH_ERRORS		=	2
	STATUS_COMPILED_WITHOUT_ERRORS		= 	3
	STATUS_EXECUTED_WITH_RUNTIME_ERRORS	=	4
	STATUS_EXECUTED_WITH_LOGIC_ERRORS	=	5

end