class ProblemsController < ApplicationController
	# [Solve a problem - Story 3.1]
	# Displays the problem statment that the user chose
	# Parameters:
	#	id: The problem statement id
	# Returns: none
	# Author: MIMI
	def show 
		@problem = Problem.find_by_id(params[:id])
		if @problem.nil?
			render "problem_not_found"
		else
			@track = @problem.track
			@topic = @track.topic
			@course = @topic.course
		end
	end

	# [Add Problem - 4.4]
	# Creates a new record to Problem Table
	# Parameters:
	#   title: problem's title through permitCreate action
	#   description: problem's description through permitCreate action
	# Returns: Redirects to edit page on success, refreshes on failure
	# Author: Abdullrahman Elhusseny
	def create
		p = Problem.new(problem_params)
		if lecturer_signed_in?
			p.owner_id = current_lecturer.id
			p.owner_type = "lecturer"
		elsif teaching_assistant_signed_in?
			p.owner_id = current_teaching_assistant.id
			p.owner_type = "teaching assistant"
		end
		p.incomplete = true
		begin
			if p.save
				redirect_to :controller => "tracks", :action => "show", :id => p.track_id
			else 
				flash.keep[:notice] = "Problem is missing paramaters"
				redirect_to :back
			end
		rescue
			flash.keep[:notice] = "Problem with the same title exists in this track"
			redirect_to :back
		end
	end

	# [Edit Problem - 4.5]
	# Shows the problem's title and description (Further development is in Sprint 1)
	# Parameters:
	#   id: The id of the problem to be edited or newly created
	# Returns: Redirects to edit page on success, refreshes on failure
	# Author: Abdullrahman Elhusseny
	def edit
		if lecturer_signed_in? || teaching_assistant_signed_in?
			@problem = Problem.find_by_id(params[:id])
			@test_cases = @problem.test_cases
			@answers = @problem.model_answers
			@track = Track.find_by_id(@problem.track_id)
			@topic = Topic.find_by_id(@track.topic_id)
			@tracks = Track.find_all_by_topic_id(@track.topic_id)
		else
			render ('public/404')
		end
	end

	# [Edit Problem - 4.5]
	# Checks if a lecturer or TA is signed in and shows the problem's add page(title & description)
	# on success and renders 404 on failure
	# Parameters:
	#  none
	# Returns: Redirects to add page on success or 404 on failure
	# Author: Abdullrahman Elhusseny
	def new
		if lecturer_signed_in? || teaching_assistant_signed_in?
			render ('new')
		else
			render ('public/404')
		end
	end

	# [Edit Problem - 4.5]
	# Update the problem's title or description
	# Parameters:
	#  problem_params: a problem's title & description
	# Returns: refreshes divisions in the page using AJAX without refreshing the whole page
	# Author: Abdullrahman Elhusseny
	def update
		@problem = Problem.find_by_id(params[:id])
		if (problem_params[:title] == @problem.title)
			if (problem_params[:description] == @problem.description)
				@message = "Problem moved to Track #{problem_params[:track_id]}"
			else
				@message = "Description updated"
				@flag = true
			end
		else
			@message = "Title updated"
			@flag = true
		end
		@problem = Problem.find_by_id(params[:id])
		@track = Track.find_by_id(problem_params[:track_id])
		if @flag == true
			if @problem.update_attributes(problem_params)
				flash.keep[:notice] = @message
				respond_to do |format|
					format.html {redirect_to :action => "edit", :id => @problem.id}
					format.js
				end
			else
				flash.keep[:notice] = "Update paramater is empty"
				respond_to do |format|
					format.html {redirect_to :action => "edit", :id => @problem.id}
					format.js
				end
			end
		elsif (@problem.track_id == problem_params[:track_id].to_i)
			flash.keep[:notice] = "The problem already belongs to this track"
			respond_to do |format|
				format.html {redirect_to :action => "edit", :id => @problem.id}
				format.js 
			end
		else
			@problems_in_track = @track.problems.find_all_by_title(@problem.title)
			if(Array(@problems_in_track).size == 0)
				if @problem.update_attributes(problem_params)
					flash.keep[:notice] = @message
					respond_to do |format|
						format.html {redirect_to :action => "edit", :id => @problem.id}
						format.js 
					end	
				else 
					flash.keep[:notice] = " Cannot change track"
					respond_to do |format|
						format.html {redirect_to :action => "edit", :id => @problem.id}
						format.js 
					end
				end
			else
				flash.keep[:notice] = "#{@track.title} has a problem with the same title"
				@track = Track.find_by_id(@problem.track_id)
				respond_to do |format|
					format.html {redirect_to :action => "edit", :id => @problem.id}
					format.js 
				end
			end
		end
	end	

	# [Edit Problem - 4.5]
	# Checks if the problem can be saved as incomplete or not
	# Parameters:
	#   params[:problem_id]: the id of the problem that was being edited
	# Returns: On success returns to the track page, on failure redirects to edit page
	# Author: Abdullrahman Elhusseny
	def done
		@problem = Problem.find_by_id(params[:problem_id])
		if @problem.test_cases.empty?
			@failure = true
			flash.keep[:notice] = "Test cases are empty #{@failure}"
			redirect_to :action => "edit", :id => @problem.id
		elsif @problem.model_answers.empty?
			@failure = true
			flash.keep[:notice] = "Answers are empty"
			redirect_to :back
		else
			@problem.incomplete = false
			flash.keep[:notice] = "Problem is saved as complete"
			redirect_to :controller => "tracks", :action => "show", :id => @problem.track_id
		end
	end	

	# [Add Problem - 4.4]
	# Passes the input of the form as paramaters for create action to use it
	# Parameters:
	#   title: problem's title
	#   description: problem's description
	#   track_id: problem's track_id
	# Returns: params to create action
	# Author: Abdullrahman Elhusseny
	private
	def problem_params
		params.require(:Problem).permit(:title , :description, :track_id)
	end
end	