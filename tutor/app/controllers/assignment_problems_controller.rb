class AssignmentProblemsController < ApplicationController

	# [Create Assignment - Story 4.27]
	# To create a new problem in an assignment and save assignment id.
	# Parameters:
	#	params[:id]: id of the assignment.
	# Returns: none 
	# Author: Nadine Adel
	def new
		session[:assignment_id] = params[:id]
		@assignment = Assignment.find_by_id(session[:assignment_id])
		@new_problem = AssignmentProblem.new
	end

	# [Create Assignment - Story 4.27]
	# To create a new problem in an assignment.
	# Parameters:
	#	problem_params[:id]: parameters that are needed to save a problem.
	# Returns:
	#	A message if the problem is saved or not.
	# Author: Nadine Adel
	def create
		@assignment = Assignment.find_by_id(session[:assignment_id])
		@new_problem = AssignmentProblem.new
		@new_problem.title = problem_params[:title]
		@new_problem.description = problem_params[:description]
		@new_problem.final_grade = 0
		@new_problem.assignment_id = session[:assignment_id]
		session[:problem_id] = @new_problem.id
		problem_exist = AssignmentProblem.find_by(title: @new_problem.title,
			assignment_id: @new_problem.assignment_id)
		if lecturer_signed_in?
			@new_problem.owner_id = current_lecturer.id
			@new_problem.owner_type = "lecturer"
		elsif teaching_assistant_signed_in?
			@new_problem.owner_id = current_teaching_assistant.id
			@new_problem.owner_type = "teaching assistant"
		end
		if problem_exist.nil?
			if @new_problem.save
				flash[:notices] = "saved"
				redirect_to :controller => 'assignment_testcases',
					:action => 'new', :assignment_id => @new_problem.id
			else
				render :action=>'new', :id => session[:assignment_id]
			end
		else
			flash[:duplicatedcreate] = "problem already exists"
			redirect_to :back
		end
	end

	# [Create Assignment - Story 4.27]
	# Used to add the problems that were chosen by the user to be added to the assignment.
	# Parameters:
	#	params[:checkbox]: array of the problems that were selected.
	# Returns:
	#	A message if the problems are added or not.
	# Author: Nadine Adel
	def complete
		@assignment = Assignment.find_by_id(session[:assignment_id])
	 	@sproblems = Array.new
	 	@check = Array.new
	 	if params[:checkbox].nil? || params[:checkbox].empty?
	 		flash[:alert] = "Please select problems to be saved"
	 		redirect_to :back
	 	else
			params[:checkbox].each do |check|
				@problem_select = Problem.find_by_id(check)
				@new_problem = AssignmentProblem.new
				@new_problem.title = @problem_select.title
				@new_problem.description = @problem_select.description
				@new_problem.assignment_id = @assignment.id
				@new_problem.final_grade = 0
				@new_problem.test_cases = @problem_select.test_cases
				@problem_exist = AssignmentProblem.find_by(title: @new_problem.title,
					assignment_id: @new_problem.assignment_id)
				if lecturer_signed_in?
					@new_problem.owner_id = current_lecturer.id
					@new_problem.owner_type = "lecturer"
				elsif teaching_assistant_signed_in?
					@new_problem.owner_id = current_teaching_assistant.id
					@new_problem.owner_type = "teaching assistant"
				end
				if @problem_exist.nil?
					if @new_problem.save
						@assignment.problems << @new_problem
						flash[:notice] = "problems are now added"
					end
				else
					@title = @problem_exist.title
					session[:title] = @title
					flash[:duplicated] = "problem already exists"
					redirect_to :back
					return
				end
			end
			redirect_to :back
		end
	end

	# [Create Assignment - Story 4.27]
	# Used to list Exercise problems that are related to the course and bank of problems.
	# Parameters:
	#	session[:title]: title of the problem that were selected.
	#	session[:assignment_id]: id of the assignment to which the problem will be added.
	# Returns: none.
	# Author: Nadine Adel
	def index
		@title = session[:title]
		@assignment = Assignment.find_by_id(session[:assignment_id])
		used_problems = @assignment.problems
		used_problems_titles = []
		used_problems.each do |problem|
			used_problems_titles << problem.title
		end
		@course_id = @assignment.course_id
		@course = Course.find_by_id(@course_id)
		@topics = @course.topics
		@tracks = Array.new
	 	@problems1 = Array.new
		if !@topics.empty?
			@topics.find_each do |topic|
				@tracksi = topic.tracks
				@tracksi.each do |track|
					@tracks.push(track)	
				end
			end
		end
		@problems = Array.new
		if !@tracks.empty?
			@tracks.each do |track|
				@probs = track.problems
				@probs.each do |problem1|
					unless used_problems_titles.include? problem1.title
						@problems.push(problem1)
					end
				end
			end
		end
		@bank = Problem.where("seen = ?", true)
		@cproblems = Array.new
		@bank.each do |contest| 
			unless used_problems_titles.include? contest.title
				@cproblems.push(contest)				
			end
		end
	end
	
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
			redirect_to :action=>'show', :id =>params[:id]
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

	# [Create Assignment - Story 4.27]
	# To get from the assignment_problem form the values needed to save new problem.
	# Parameters: none
	# Returns: 
	#	title: title of the problem.
	#	description: description of the problem.
	# Author: Nadine Adel
	private
	def problem_params
		params.require(:assignment_problem).permit(:title, :description, :final_grade)
	end

end