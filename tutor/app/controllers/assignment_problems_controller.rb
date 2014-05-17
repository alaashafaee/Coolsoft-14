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

	# [Edit Assignment - Story 4.28]
	# Updates the problem needs to be edited in the database.
	# Parameters: 
	#	params[:id]: Id of the problem.
	# Returns: none
	# Author: Nadine Adel
	def update
		@problem = AssignmentProblem.find_by_id(params[:id])
		if @problem.update_attributes(problem_params)
			flash[:notice] = "Your problem is now updated"
			redirect_to :back
		else
			render :action=>'edit', :id => @problem.id
		end
	end

	# [Edit Assignment - Story 4.28]
	# deletes and remove the problem selected from the database.
	# Parameters: 
	#	params[:id]: Id of the problem.
	# Returns: none
	# Author: Nadine Adel
	def destroy
		@problem = AssignmentProblem.find_by_id(params[:id])
		@problem.destroy
		flash[:notice] = "Answer successfully Deleted"
		redirect_to :controller=> 'assignments',
			:action=> 'show', :id=> @problem.assignment_id
	end

private
	def problem_params
			params.require(:assignment_problem).permit(:title, :description, :final_grade)
	end
end