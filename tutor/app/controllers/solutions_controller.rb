class SolutionsController < ApplicationController
	# [Code Editor: Write Code - Story 3.3]
	# Creates a solution for a problem that the student chose
	# and outputs 2 flush messages for success and failure scenarios 
	# Parameters: 
	# 	solution_params: submitted from the form_for
	# Returns: none
	# Author: MOHAMEDSAEED
	def create
		if params[:commit] == 'Submit'
			@solution = Solution.new(solution_params)
			@solution.student_id = current_student.id
			@solution.status = 0
			@solution.length = @solution.code.length

			if @solution.save
				flash[:success] = "Your Solution has been submitted successfully"
				redirect_to :back
			else
				flash[:alert] = "Blank Submissions are not allowed !!!"
				redirect_to :back
			end
		elsif params[:commit] == 'Compile'
		 	flash[:alert] = "compileeeeeeeeeeee!!!"
			redirect_to :back
		end


	end



	# [Code Editor: Write Code - Story 3.3]
	# Fills the ID of the problem , code from the form_for 
	# Parameters:
	# 	code: The written code for the problem
	# 	problem_id: Hidden field for problem id
	# Returns: none
	# Author: MOHAMEDSAEED
	private
	def solution_params
		params.require(:solution).permit(:code , :problem_id)
	end
end