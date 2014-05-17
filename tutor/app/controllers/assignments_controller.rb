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

	# [Edit Assignment - Story 4.28]
	# Updates the assignment needs to be edited in the database.
	# Parameters: 
	#	params[:id]: Id of the assignment.
	# Returns: none
	# Author: Nadine Adel
	def update
		@assignment = Assignment.find_by_id(params[:id])
		if @assignment.update_attributes(assignment_params)
			flash[:notice] = "Your Assignment is now updated"
			redirect_to :action=>'show' , :id =>params[:id]
		else
			render :action=>'edit', :id => @assignment.id
		end
	end

	# [Edit Assignment - Story 4.28]
	# deletes and remove the assignment selected from the database.
	# Parameters: 
	#	params[:id]: Id of the assignment.
	# Returns: none
	# Author: Nadine Adel
	def destroy
		@assignment = Assignment.find_by_id(params[:id])
		@assignment.destroy
		flash[:notice] = "Assignment is successfully Deleted"
		redirect_to :controller=>'courses',
			:action=> 'show',:id=> @assignment.course_id
	end

	private
	def assignment_params
		params.require(:assignment).permit(:title, :description, :due_date)
	end

end