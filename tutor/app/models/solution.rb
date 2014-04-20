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
	# and show the compilation, runtime and logic errors if exist
	# Parameters: 
	# 	code: the code written in the editor from the form_for
	#   testcases: the testcases for the given problem 
	# Returns: a hash response containing status for the solution,
	# 			solution errors or success message.
	# Author: MOHAMEDSAEED
	def validate(code , testcases)
		response = {:status => 0 , :success => [] , :failure => [] }
		compile_result = Compiler.compile(code)
		if(compile_result[:sucess])
			testcases.each do |tc| 
				input = tc.input 
				expected_output = tc.output
				runtime_check = Executer.check_execute(compile_result[:class_name] , input)
				if(runtime_check)
					runtime_result = Executer.execute(compile_result[:class_name] , input)
					if runtime_result != expected_output?
						response[:failure] << "Logic error: for input: " + input +" , expected output: " +
						expected_output +" but your output was: " + runtime_result   
						response[:status] = 5
					else
						response[:success] << "Your Solution is correct , Passed"
						response[:status] = 1 	
					end
				else
					execute_message = Executer.execute(compile_result[:class_name] , input)
					response[:status] = 4
					response[:failure] << execute_message
				end
			end
		else 
			compile_message = Compiler.compileFeedback(compile_result)
			response[:status] = 2
			response[:failure] << compile_message 
		end
		return response
	end
	
	#Constants
	STATUS_SUBMITTED	= 	0
	STATUS_ACCEPTED		=	1
	STATUS_COMPILED_WITH_ERRORS		=	2
	STATUS_COMPILED_WITHOUT_ERRORS		= 	3
	STATUS_EXECUTED_WITH_RUNTIME_ERRORS	=	4
	STATUS_EXECUTED_WITH_LOGIC_ERRORS	=	5

end
