class AssignmentProblemsController < ApplicationController
	# [View List Of Assignments - Story 4.24]
	# Lists the list of problems in a
	#	particular assignment
	# Parameters: 
	#	id: Id of the problem.
	# Returns: none
	# Author: Lin Kassem
	def show
		@problem = AssignmentProblem.find_by_id(params[:id])
		if @problem.nil?
			render "problem_not_found"
		else
			@assignment = @problem.assignment
			@course = @assignment.course
			@can_edit = @course.can_edit(current_lecturer)
			@can_edit||= @course.can_edit(current_teaching_assistant)
		end
	end

	# [View List Of Assignments - Story 4.24]
	# Allows the editing of a particular problem
	#	in a particular assignment
	# Parameters: 
	#	id: Id of the problem.
	# Returns: none
	# Author: Lin Kassem
	def edit
		@problem = AssignmentProblem.find_by_id(params[:id])
		if @problem.nil?
			render "problem_not_found"
		else
			@assignment = @problem.assignment
			@course = @assignment.course
			@can_edit = @course.can_edit(current_lecturer)
			@can_edit||= @course.can_edit(current_teaching_assistant)
		end
	end
end