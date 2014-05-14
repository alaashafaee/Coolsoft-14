class ProblemsController < ApplicationController
	
	# [Solve a problem - Story 3.1]
	# Displays the problem statment that the user chose
	# Parameters:
	#	id: The problem statement id
	# Returns: none
	# Author: MIMI + Rami Khalil
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
	#	title: problem's title through permitCreate action
	#	description: problem's description through permitCreate action
	# Returns:
	#	Redirects to edit page on success, refreshes on failure
	# Author: Abdullrahman Elhusseny
	def create
		problem = Problem.new(problem_params)
		if lecturer_signed_in?
			problem.owner_id = current_lecturer.id
			problem.owner_type = "lecturer"
		elsif teaching_assistant_signed_in?
			problem.owner_id = current_teaching_assistant.id
			problem.owner_type = "teaching assistant"
		end
		problem.incomplete = true
		begin
			if problem.save
				redirect_to :action => "edit", :id => problem.id
			else
				flash.keep[:notice] = "Problem is missing paramaters"
				redirect_to :back
			end
		rescue
			flash.keep[:notice] = "The track has a problem with the same title"
			redirect_to :back
		end
	end

	# [Edit Problem - 4.5]
	# Shows the problem's title and description (Further development is in Sprint 1)
	# Parameters:
	#	id: The id of the problem to be edited or newly created
	# Returns:
	#	Redirects to edit page on success, refreshes on failure
	# Author: Abdullrahman Elhusseny
	def edit
		if lecturer_signed_in? || teaching_assistant_signed_in?
			@problem = Problem.find_by_id(params[:id])
			@test_cases = @problem.test_cases
			@answers = @problem.model_answers
			@track = Track.find_by_id(@problem.track_id)
			@topic = Topic.find_by_id(@track.topic_id)
			@tracks = Track.where(topic_id: @track.topic_id)
			@snippet = @problem.snippet
		else
			render ('public/404')
		end
	end

	# [Edit Problem - 4.5]
	# Checks if a lecturer or TA is signed in and shows the problem's add page(title & description)
	# on success and renders 404 on failure
	# Parameters:
	#	track_id: The track id of the track that the problem will be added to
	# Returns:
	#	Redirects to add page on success or 404 on failure
	# Author: Abdullrahman Elhusseny
	def new
		if lecturer_signed_in? || teaching_assistant_signed_in?
			if params[:id].blank?
				render ('public/404')
			else
				render ('new')
			end
		else
			render ('public/404')
		end
	end

	# [Remove Problem - Story 4.18]
	# This action takes the problem id, remove it from the database
	#	and then redirects the user to the show page of the track that had the problem
	#	with a "Problem successfully Deleted" message.
	# Parameters:
	#	params[:id]: The current problem's id
	# Returns: 
	#	flash[:notice]: A message indicating the success of the deletion
	# Author: Ahmed Atef
	def destroy
		@track = Problem.find_by_id(params[:id]).track_id
		if Problem.find_by_id(params[:id]).destroy
			flash[:notice] = "Problem successfully Deleted"
			redirect_to(:controller => 'tracks',
				 :action => 'show' ,:id => @track)
		end
	end

	# [Edit Problem - 4.5]
	# Update the problem's title, description or track
	# Parameters:
	#	problem_params: a problem's title, description & track_id
	# Returns:
	#	Refreshes divisions in the page using AJAX without refreshing the whole page
	# Author: Abdullrahman Elhusseny + Rami Khalil
	def update
		@problem = Problem.find_by_id(params[:id])
		@track = Track.find_by_id(@problem.track_id)
		@tracks = Track.where(topic_id: @track.topic_id)
		if problem_params[:title] != @problem.title
			@message = "Title updated"
		elsif problem_params[:description] != @problem.description
			@message = "Description updated"
		elsif problem_params[:track_id].to_i != @problem.track_id
			@message = "Problem is moved to Track #{problem_params[:track_id]}"
		elsif problem_params[:snippet] != @problem.snippet
			@message = "Problem code template updated."
		else
			flash.keep[:notice] = "You have entered the same parameters. No change has been made!"
		end

		if problem_params[:track_id].to_i == @problem.track_id
			if problem_params[:title] != @problem.title ||
				problem_params[:description] != @problem.description ||
				problem_params[:snippet] != @problem.snippet
				begin
					if @problem.update_attributes(problem_params)
						flash.keep[:notice] = @message
						respond_to do |format|
							format.html {redirect_to :action => "edit",
								:id => @problem.id}
							format.js
						end
					else
						flash.keep[:notice] = "Update paramater is empty"
						@problem = Problem.find_by_id(params[:id])
						respond_to do |format|
							format.html {redirect_to :action => "edit",
								:id => @problem.id}
							format.js
						end
					end
				rescue
					flash.keep[:notice] = "The track has a problem with the same title"
					@problem = Problem.find_by_id(params[:id])
					respond_to do |format|
						format.html {redirect_to :action => "edit",
							:id => @problem.id}
						format.js
					end
				end
			end
		else
			@track = Track.find_by_id(problem_params[:track_id])
			@problems_in_track = @track.problems.where(title: @problem.title)
			if @problems_in_track.size == 0
				if @problem.update_attributes(problem_params)
					flash.keep[:notice] = @message
					respond_to do |format|
						format.html {redirect_to :action => "edit",
							:id => @problem.id}
						format.js
					end
				end
			else
				flash.keep[:notice] = "#{@track.title} has a problem with the same title"
				@track = Track.find_by_id(@problem.track_id)
				respond_to do |format|
					format.html {redirect_to :action => "edit",
						:id => @problem.id}
					format.js
				end
			end
		end
	end

	# [Edit Problem - 4.5]
	# Checks if problem is complete or not by checking the number of test cases and answers
	# Parameters:
	#	problem_id: ID of the problem being edited
	# Returns:
	#	On success redirects to the track page, on failure redirects to the edit page
	# Author: Abdullrahman Elhusseny
	def done
		@problem = Problem.find_by_id(params[:problem_id])
		if @problem.model_answers.empty? || @problem.test_cases.empty?
			@failure = true
			flash.keep[:notice] = "Problem is incomplete, 
			please add necessary paramaters or save as incomplete"
			redirect_to :action => "edit", :id => @problem.id
		else
			@problem.incomplete = false
			@problem.save
			redirect_to :controller => "tracks", :action => "show", :id => @problem.track_id
		end
	end

	# [Add Problem - 4.4]
	# Passes the input of the form as paramaters for create action to use it
	# Parameters: none
	# Returns:
	#	Filtered parameter list for problems
	# Author: Abdullrahman Elhusseny + Rami Khalil
	private
		def problem_params
			params.require(:Problem).permit(:title, :description, :track_id, :snippet)
		end

end