class AssignmentsController < ApplicationController
	
	# [View List Of Assignments - Story 4.24]
	# Shows a particular assignment in a course
	# Parameters: 
	#	id: Id of the assignment.
	# Returns: 
	#	The view of the assignmet if found, 
	#	redirects to 'public/404' otherwise.
	#	Lables denoting whether the assignment
	#	is submitted or corrected. 
	# Author: Lin Kassem
	def show
		@assignment_corrected_flag = false
		@assignment_submitted_flag = false
		id = params[:id]
		@assignment = Assignment.find_by_id(id)
		@grade_records = []
		@submitted_records = []
		if student_signed_in?
			student_id = current_student.id
		end
		if @assignment
			@course = @assignment.course
			@problems = @assignment.problems
			if teaching_assistant_signed_in?
				@can_edit = @course.can_edit(current_teaching_assistant)
			end
			if lecturer_signed_in?
				@can_edit ||= @course.can_edit(current_lecturer)
			end
		else
			render ('public/404')
		end
		@problems.each do |p|
			@grade_records = @grade_records + 
			Grade.where("student_id = ? AND problem_id = ?", student_id, p.id )
		end
		if @grade_records.size < @problems.size
			@assignment_corrected_flag = false
		else
			@assignment_corrected_flag = true
		end
		@problems.each do |p|
			@submitted_records = @submitted_records + 
			Solution.where("student_id = ? AND problem_id = ? AND problem_type = ?",
			student_id, p.id , "AssignmentProblem")
		end
		if @submitted_records.size < @problems.size
			@assignment_submitted_flag = false
		else
			@assignment_submitted_flag = true
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
			redirect_to :controller=>'assignmentproblems',
				:action=>'new', :id=> params[:id]
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
			:action=> 'show', :id=> @assignment.course_id
	end

	# [View Corrected Assignment - Story 4.26]
	# Shows TA's correction for the student's corrected
	#	assignment.
	# Parameters:
	#	params[:id]: The course id
	# Returns: none
	# Author: Lin Kassem
	def show_correction
		id = params[:id]
		@assignment = Assignment.find_by_id(id)
		if student_signed_in?
			student_id = current_student.id
		end
		@course = @assignment.course
		@problems = @assignment.problems
		@solutions = []
		@lines = []
		@notes = []
		@counter = 0 
		@problems.each do |p|
			@solutions = @solutions + 
			Solution.where("student_id = ? AND problem_id = ?", student_id, p.id)
		end
		@solutions.each do |sol|
			@notes = @notes +
			 Note.where("solution_id = ?", sol.id) 
		end
	end

	# [Edit Assignment - Story 4.28]
	# To get from the assignment form the values needed to save edited assignment.
	# Parameters: none
	# Returns: 
	#	title: title of the assignment.
	#	description: description of the assignment.
	#	date: duedate of the assignment.
	# Author: Nadine Adel
	private
	def assignment_params
		params.require(:assignment).permit(:title, :description, :due_date)
	end

end