class SolutionsController < ApplicationController

	# [Code Editor: Write Code - Story 3.3]
	# Creates a solution for a problem that the student chose
	#	and outputs 2 flash messages for success and failure scenarios
	# Parameters:
	#	solution_params: submitted from the form_for
	# Returns: none
	# Author: MOHAMEDSAEED
	def create
		param = solution_params
		code = param[:code]
		student = current_student.id
		problem = param[:problem_id]
		time = param[:time]
		problem_type = param[:problem_type]
		class_name = param[:class_name]
		lang = param[:lang]
		result = SolutionsLayer.validate(lang, code, student, problem,
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
		lang = params[:lang]
		cases = if params[:case] then params[:case] else "" end
		result = SolutionsLayer.execute(lang, code, id, pid,
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
		lang = param[:lang]
		compiler_feedback = SolutionsLayer.compile(lang, code, student, 
			problem, problem_type, class_name)
		render json: compiler_feedback
	end

	# [Mark Solution - Story 4.29]
	# Allows a TA to mark a solution of a student
	# Parameters:
	#	submission_id: the id of the solution to be marked
	# Returns: none
	# Author: Abdullrahman Elhusseny
	def mark_solution
		if lecturer_signed_in? || teaching_assistant_signed_in?
			@solution = Solution.find_by_id(params[:submission_id])
			if !@solution.blank?
				@lines = @solution.code.split("\n")
				@notes = Hash.new
				@counter = 0
				@lines.each do |line|
					@counter+= 1
					@notes[@counter]= Note.where(solution_id: @solution.id, line: @counter).last
				end
				@student = Student.find_by_id(@solution.student_id)
				@problem = AssignmentProblem.find_by_id(@solution.problem_id)
				@course = @problem.assignment.course
				@can_edit = @course.can_edit(current_lecturer)
				@can_edit||= @course.can_edit(current_teaching_assistant)
				if !@can_edit
					render ('public/404')
				end
			else
				render ('public/404')
			end
		else
			render ('public/404')
		end
	end

	# [Mark Solution - Story 4.29]
	# Allows a TA to view all submitted solutions to a specific assignment
	# Parameters:
	#	problem_id: the id of the assignment problem to view its submissions
	# Returns: none
	# Author: Abdullrahman Elhusseny
	def view_submissions
		@problem = AssignmentProblem.find_by_id(params[:problem_id])
		@submissions = @problem.solutions.group(:student_id)
		@students = Hash.new
		@counter = 0
		@submissions.each do |submission|
			@counter+=1
			@students[@counter] = Student.find_by_id(submission.student_id)
		end
		@course = @problem.assignment.course
		@can_edit = @course.can_edit(current_lecturer)
		@can_edit||= @course.can_edit(current_teaching_assistant)
		if !@can_edit
			render ('public/404')
		end
	end

	# [Code Editor: Write Code - Story 3.3]
	# Permits the id of the problem, code from the form_for
	# Parameters:
	# 	code: The written code for the problem
	# 	problem_id: Hidden field for problem id
	# Returns:
	# 	none
	# Author: MOHAMEDSAEED
	def mark_solution
		@solution.find_by_id(params[:id])
		@problem = @solution.problem
		@student = @solution.student
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
		params.permit(:code, :problem_id, :time, :class_name, :problem_type, :lang)
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