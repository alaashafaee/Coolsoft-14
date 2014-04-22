class SolutionsController < ApplicationController

	# [Code Editor: Write Code - Story 3.3]
	# Creates a solution for a problem that the student chose
	#	and outputs 2 flush messages for success and failure scenarios 
	# Parameters: 
	#	solution_params: submitted from the form_for
	# Returns: none
	# Author: MOHAMEDSAEED
	def create
		if params[:commit] == 'Submit'
			@solution = Solution.new(solution_params)
			@solution.student_id = current_student.id
			@solution.status = 0
			@solution.length = @solution.code.length
			if @solution.save
				flash[:success] = "Your solution has been submitted successfully"
			else
				flash[:alert] = "Blank submissions are not allowed!!!"
			end
			redirect_to :back
		elsif params[:commit] == 'Compile'
			compile_solution
		end
	end

	# [Compiler: Compile - Story 3.4]
	# Creates a soution for the current problem in the database and compiles it.
	#	Then it places the previous code and the compilation results and feedback in the flash hash.
	# Parameters:
	#	solution_params: submitted from the form_for
	# Returns: none
	# Author: Ahmed Moataz
	def compile_solution
		@solution = Solution.new(solution_params)
		@solution.student_id = current_student.id
		@solution.length = @solution.code.length
		if @solution.save
			compiler_feedback = Compiler.compiler_feedback(@solution)
			if compiler_feedback[:success]
				@solution.status = 3
				flash[:compiler_success] = "Compilation Succeeded!"
				flash[:previous_code] = compiler_feedback[:previous_code]
			else
				@solution.status = 2
				flash[:compiler_fail] = "Compilation Failed!"
				flash[:compiler_feedback] = compiler_feedback[:errors]
				flash[:previous_code] = compiler_feedback[:previous_code]
			end
			@solution.save
		else
			flash[:alert] = "You did not write any code!"
		end
		redirect_to :back
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
		params.require(:solution).permit(:code, :problem_id)
	end

end