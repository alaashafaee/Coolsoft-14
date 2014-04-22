class SolutionsController < ApplicationController

	# [Code Editor: Write Code - Story 3.3]
	# submits a solution for a problem that the student chose
	# and show an alert box  for success and failure scenarios 
	# Parameters: 
	# 	solution_params: submitted from the form_for
	# Returns: none
	# Author: MOHAMEDSAEED
	def create
		solution = Solution.new({problem_id: params[:problem_id], code: params[:code],
					time: params[:time]})
		solution.student_id = current_student.id
		solution.length = solution.code.length
		testcases = solution.problem.test_cases
		#response_message = Solution.validate(solution.code , testcases , file)
		response_message = {:success => ["Success"], :failure => ["Failure"]}
		#solution.status = response_message[:status]
		solution.save
		render json: response_message
		#end
	end

	# [Code Editor: Write Code - Story 3.3]
	# Fills the ID of the problem , code from the form_for 
	# Parameters:
	# 	code: The written code for the problem
	# 	problem_id: Hidden field for problem id
	# Returns: none
	# Author: MOHAMEDSAEED
	# private
	# def solution_params
	# 	params.require(:solution).permit(:code , :problem_id)
	# end
	
end