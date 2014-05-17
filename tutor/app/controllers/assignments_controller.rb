class AssignmentsController < ApplicationController

	# [Create Assignment - Story 4.27]
	# To create a new assignment and save course id.
	# Parameters:
	#	params[:course_id]: id of the course.
	# Returns: none 
	# Author: Nadine Adel
	def new
		session[:course_id] = params[:course_id]
		@course = Course.find_by_id(session[:course_id])
		@new_assignment = Assignment.new
	end

	# [Create Assignment - Story 4.27]
	# create a new assignment.
	# Parameters:
	#	params[]: the values needed for the assignment to be saved.
	# Returns: none 
	# Author: Nadine Adel
	def create 
		@course = Course.find_by_id(session[:course_id])
		@new_assignment = Assignment.new
		@new_assignment.title = assignment_params[:title]
		@new_assignment.description = assignment_params[:description]
		@new_assignment.due_date = assignment_params[:date]
		@new_assignment.course_id = session[:course_id]
		t = DateTime.new(assignment_params["date(1i)"].to_i,
			assignment_params["date(2i)"].to_i, assignment_params["date(3i)"].to_i )
		@new_assignment.due_date = t
		if lecturer_signed_in?
			@new_assignment.owner_id = current_lecturer.id
			@new_assignment.owner_type = "lecturer"
		elsif teaching_assistant_signed_in?
			@new_assignment.owner_id = current_teaching_assistant.id
			@new_assignment.owner_type = "teaching assistant"
		end
		if @new_assignment.save
			redirect_to :controller => 'assignment_problems', :action => 'new',
				:id => @new_assignment.id
		else
			render :action=>'new', :course_id => params[:course_id]
		end
	end

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

	# [Create Assignment - Story 4.27]
	# To get from the assignment form the values needed to save new assignment.
	# Parameters: none
	# Returns: 
	#	title: title of the assignment.
	#	description: description of the assignment.
	#	date: duedate of the assignment.
	# Author: Nadine Adel
	private
	def assignment_params
		params.require(:assignment).permit(:title, :description, :date)
	end	
end