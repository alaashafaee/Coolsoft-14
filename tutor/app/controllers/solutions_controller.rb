class SolutionsController < ApplicationController

	# [Code Editor: Write Code - Story 3.3]
	# submits a solution for a problem that the student chose
	# Parameters: 
	# 	solution_params: submitted from the form_for
	# Returns: none
	# Author: MOHAMEDSAEED
	def create
		@solution = Solution.new({problem_id: params[:problem_id], code: params[:code],
					time: params[:time]})
		@solution.student_id = current_student.id
		@solution.length = @solution.code.length
		testcases = @solution.problem.test_cases
		@solution.status = 0
		#@solution.save
		#file = @solution.file_name
		#response_message = Solution.validate(solution.code , testcases , file)
		response_message = {:success => ["Success"], :failure => ["Failure"]}
		#solution.status = response_message[:status]
		#solution.save
		render json: response_message
	end
	
end