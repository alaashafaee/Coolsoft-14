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

		@assignment_corrected_flag = false
		@found = false
		if student_signed_in?
			student_id = current_student.id
		end
		@grade_records = Grade.where("student_id = ?", student_id)
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

		@new_grade_records = []

		@problems.each do |p|
			@new_grade_records = @new_grade_records + Grade.where("student_id = ? AND problem_id = ?", student_id, p.id )
		end

		if @new_grade_records.size < @problems.size
			@assignment_corrected_flag = false
		else
			@assignment_corrected_flag = true
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
end