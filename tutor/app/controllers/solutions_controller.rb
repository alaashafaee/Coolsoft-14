class SolutionsController < ApplicationController

	# [Code Editor: Write Code - Story 3.3]
	# Creates a solution for a problem that the student chose
	#	and outputs 2 flash messages for success and failure scenarios
	# Parameters:
	#	solution_params: submitted from the form_for
	# Returns: none
	# Author: MOHAMEDSAEED
	def create
		if lecturer_signed_in? || teaching_assistant_signed_in?
			render json: {}
		end
		param = solution_params
		code = param[:code]
		student = current_student.id
		problem = param[:problem_id]
		time = param[:time]
		result = SolutionsLayer.validate "java", code, student, problem, time
		render json: result
	end

	# [Compiler: Test - Story 3.15]
	# This Action runs the execute method from the Executer model
	# Parameters:
	#	@solution: The submitted solution
	# Returns:
	# 	A flash message containing the appropriate reply
	# Author: Ahmed Akram
	def execute
		if lecturer_signed_in? || teaching_assistant_signed_in?
			render json: {}
		end
		id = current_student.id
		pid = params[:problem_id]
		code = params[:code]
		cases = if params[:input] then params[:input] else "" end
		result = SolutionsLayer.execute "java", code, id, pid, cases
		render json: result
	end

	# [Compiler: Compile - Story 3.4]
	# Creates a soution for the current problem in the database and compiles it.
	#	Then it places the previous code and the compilation results and feedback in the flash hash.
	# Parameters:
	#	solution_params: submitted from the form_for
	# Returns: none
	# Author: Ahmed Moataz
	def compile_solution
		if lecturer_signed_in? || teaching_assistant_signed_in?
			render json: {}
		end
		param = solution_params
		code = param[:code]
		student = current_student.id
		problem = param[:problem_id]
		compiler_feedback = SolutionsLayer.compile "java", code, student, problem
		render json: compiler_feedback
	end

	private
	# [Code Editor: Write Code - Story 3.3]
	# Permits the id of the problem, code from the form_for
	# Parameters:
	# 	code: The written code for the problem
	# 	problem_id: Hidden field for problem id
	# Returns:
	# 	none
	# Author: MOHAMEDSAEED
	def solution_params
		params.permit(:code, :problem_id, :time)
	end

	# [Compiler: Test - Story 3.15]
	# Permits the input
	# Parameters:
	#	none
	# Returns:
	# 	params[:input]: The test case entered by the solver
	# Author: Ahmed Akram
	def input
		params.require(:solution).permit(:input)
	end

end