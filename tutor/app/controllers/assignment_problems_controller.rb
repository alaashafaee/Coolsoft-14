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
	def update
		@problem = AssignmentProblem.find_by_id(params[:id])
		if @problem.update_attributes(problem_params)
			flash[:notice] = "Your problem is now updated"
			redirect_to :back
		else
			render :action=>'edit', :id => @problem.id
		end
	end
	def destroy
		@problem = AssignmentProblem.find_by_id(params[:id])
		@current = Assignment.find_by_id(@problem.assignment_id)
		if @current.problems.count == 1
			flash[:notice] = "Cannot delete problem's last model answer"
			redirect_to :back and return
		elsif @problem.destroy
			flash[:notice] = "Answer successfully Deleted"
			redirect_to :controller=>'assignments' ,:action=> 'show',:id=>@problem.assignment_id
		end
	end
private
	def problem_params
			params.require(:assignment_problem).permit(:title, :description, :final_grade)
	end
end