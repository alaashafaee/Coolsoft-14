class AssignmentsController < ApplicationController
	# [View List Of Assignments - Story 4.24]
	# Shows a particular assignment in a course
	# Parameters: 
	#	id: Id of the assignment.
	# Returns: 
	#	The view of the assignmet if found, 
	#	redirects to 'public/404' otherwise.
	# Author: Lin Kassem
	def show
		id = params[:id]
		@assignment = Assignment.find_by_id(id)
		if @assignment
			@course = @assignment.course
			@problems = @assignment.problems
			@can_edit = @course.can_edit(current_lecturer)
			@can_edit||= @course.can_edit(current_teaching_assistant)
		else
			render ('public/404')
		end
		if student_signed_in?
		student_id = current_student.id
		end
		@submitted_problems = []
		@all_problems_submitted = false 
		@problems.each do |p|
			@submitted_problems = @submitted_problems + 
				Solution.where("student_id = ? AND problem_id = ? AND problem_type = ?",
				 student_id, p.id, "AssignmentProblem")
		end
		if @submitted_problems.size == @problems.size &&
				@assignment.due_date > Date.today
			@all_problems_submitted = true
		end
	end

	# [View List Of Assignments - Story 4.24]
	# Allows the editing of a particular assignment
	# Parameters: 
	#	id: Id of the assignment.
	# Returns: none
	# Author: Lin Kassem
	def edit
		@assignment = Assignment.find_by_id(params[:id])
		if @assignment.nil?
			render "problem_not_found"
		else
			@course = @assignment.course
			@can_edit = @course.can_edit(current_lecturer)
			@can_edit||= @course.can_edit(current_teaching_assistant)
		end
	end

	def submit
				@assignment = Assignment.find_by_id(params[:id])
		if student_signed_in?
			student_id = current_student.id
		end
		#@assignment = Assignment.find_by_id(params[:id])
		@problems = @assignment.problems
		@submitted_problems = []
		@all_problems_submitted = false 
		@problems.each do |p|
			@submitted_problems = @submitted_problems + 
				Solution.where("student_id = ? AND problem_id = ?", student_id, p.id)
		end
		if @submitted_problems.size == @problems.size
			@all_problems_submitted = true
		end
	end

end