class GradesController < ApplicationController

	# [Grade Solution - 4.30]
	# creates a new record to Grade Table
	# Parameters:
	#	grade: grade given by the TA to the student in a specific problem
	#	student_id: the id of the student who submitted the solution
	#	problem_id: the id of the problem that the student solved
	# Returns: none
	# Author: Abdullrahman Elhusseny
	def create
		grade = Grade.new(grade_params)
		@problem = AssignmentProblem.find_by_id(grade_params[:problem_id])
		if lecturer_signed_in?
			grade.editor_id = current_lecturer.id
			grade.editor_type = "lecturer"
		elsif teaching_assistant_signed_in?
			grade.editor_id = current_teaching_assistant.id
			grade.editor_type = "teaching assistant"
		end
		if grade_params[:grade].to_i > @problem.final_grade
			flash.keep[:notice] = "Please enter a value less than the total grade of the problem!"
		elsif grade.save
			flash.keep[:notice] = "Grade is saved!"
		else
			flash.keep[:notice] = "Please enter a grade!"
		end
		redirect_to :back
	end

	# [Grade Solution - 4.30]
	# updates a record to Grade Table
	# Parameters:
	#	grade: grade given by the TA to the student in a specific problem
	#	student_id: the id of the student who submitted the solution
	#	problem_id: the id of the problem that the student solved
	# Returns: none
	# Author: Abdullrahman Elhusseny
	def update
		@grade = Grade.find_by_id(params[:id])
		@problem = AssignmentProblem.find_by_id(grade_params[:problem_id])
		if grade_params[:grade].to_i > @problem.final_grade
			flash.keep[:notice] = "Please enter a value less than the total grade of the problem!"
		elsif @grade.update_attributes(grade_params)
			flash.keep[:notice] = "Grade Updated"
		else
			flash.keep[:notice] = "Please enter a grade!"
		end
		redirect_to :back
	end

	# [Grades' List - 4.31]
	# shows records of Grade Table in a specific course
	# Parameters:
	#	assignment_id: the id of the assignment to be viewed its grades
	# Returns: none
	# Author: Abdullrahman Elhusseny
	def view_grades
		@assignment = Assignment.find_by_id(params[:assignment_id])
		@problems = @assignment.problems
		@students = @assignment.course.students
		@grade = 0
		@grades = Hash.new
		@counter = 1
		@students.each do |student|
			@problems.each do |problem|
				grade = Grade.where(problem_id: problem.id, student_id: student.id).first
				if grade
					@grades[@counter] = grade.grade
				else
					@grades[@counter] = 0
				end
				@counter += 1
			end
		end
	end

	# [Grade Solution - 4.30]
	# passes the input of the form as paramaters for create & update action
	# Parameters:
	#	grade: grade given by the TA to the student in a specific problem
	#	student_id: the id of the student who submitted the solution
	#	problem_id: the id of the problem that the student solved
	# Returns:
	#	params to create action & update action
	# Author: Abdullrahman Elhusseny
	private
		def grade_params
			params.require(:Grade).permit(:grade, :problem_id, :student_id)
		end
end
