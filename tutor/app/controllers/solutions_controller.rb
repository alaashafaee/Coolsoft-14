class SolutionsController < ApplicationController

	# [Code Editor: Write Code - Story 3.3]
	# Creates a solution for a problem that the student chose
	# Parameters:
	#	solution_params: the parameters needed for the submitted solution
	# Returns: JSON object containing the results of running the testcases of 
	#	the submitted solution
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
		problem_type = param[:problem_type]
		class_name = param[:class_name]
		result = SolutionsLayer.validate("java", code, student, problem,
			problem_type, class_name, time)
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
		problem_type = params[:problem_type]
		class_name = params[:class_name]
		cases = if params[:input] then params[:input] else "" end
		result = SolutionsLayer.execute("java", code, id, pid,
			problem_type, class_name, cases)
		render json: result
	end

	# [Compiler: Compile - Story 3.4]
	# Creates a soution for the current problem in the database and compiles it.
	# Parameters:
	#	solution_params: submitted from the form_for
	# Returns: none
	# Author: Ahmed Moataz
	def compile_solution
		param = solution_params
		code = param[:code]
		student = current_student.id
		problem = param[:problem_id]
		problem_type = param[:problem_type]
		class_name = param[:class_name]
		compiler_feedback = SolutionsLayer.compile("java", code, student,
			problem, problem_type, class_name)
		render json: compiler_feedback
	end

	private
	# [Code Editor: Write Code - Story 3.3]
	# Permits the id of the problem, code from the form_for
	# Parameters:
	# 	code: The written code for the problem
	# 	problem_id: Hidden field for problem id
	#	time: the time taken by the student to solve the problem
	#	class_name: the name of the class to be built
	#	problem_type: the type of the problem to be solved
	# Returns:
	# 	none
	# Author: MOHAMEDSAEED
	def solution_params
		params.permit(:code, :problem_id, :time, :class_name, :problem_type)
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