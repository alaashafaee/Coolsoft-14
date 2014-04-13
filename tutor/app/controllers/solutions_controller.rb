class SolutionsController < ApplicationController
	# [Code Editor: Write Code - Story 3.3]
	# Creates a solution for a problem that the student chose
	# Parameters: ID of the problem , ID of current student , code from the form_for
	# outputs 2 flush messages for success and failure scenarios 
	# Author: @MOHAMEDSAEED
	def create
		@solution = Solution.new(solution_params)
		@solution.student_id =  session["user_id"]
		#current_user should be used instead of Session - waiting for Khaled's Part
		@solution.status = 0
		@solution.length = @solution.code.length

		if @solution.save
			flash[:success] = "Your Solution has been submitted successfully"
			redirect_to :back
		else
			flash[:alert] = "Blank Submissions are not allowed !!!"
			redirect_to :back
		end
	end

	# [Code Editor: Write Code - Story 3.3]
	# Fills the ID of the problem , code from the form_for 
	# Author: @MOHAMEDSAEED
	private
	def solution_params
		params.require(:solution).permit(:code , :problem_id)
	end
end