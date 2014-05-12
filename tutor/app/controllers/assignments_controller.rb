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
	end
end