class ProblemsController < ApplicationController
	
	# [Solve a problem - Story 3.1]
	# Displays the problem statment that the user chose
	# Parameters:
	#	id: The problem statement id
	# Returns: none
	# Author: MIMI
	def show
		@contest = Contest.find_by_id(params[:contest_id])
		@problem = Problem.find_by_id(params[:id])
		if @problem.nil?
			render "problem_not_found"
		else
			@track = @problem.track
			@topic = @track.topic
			@course = @topic.course
			@snippet = @problem.snippet
		end
	end

	# [Add Problem - 4.4]
	# Creates a new record to Problem Table
	# Parameters:
	#	title: problem's title through permitCreate action
	#	description: problem's description through permitCreate action
	#	flag: identification flag to decide between add or editing.
	# Returns:
	#	Redirects to edit page on success, refreshes on failure
	# Author: Abdullrahman Elhusseny + Ahmed Osam
	def create
		@problem = Problem.new
		@problem.title = problem_params_add[:title]
		@problem.description = problem_params_add[:description]
		@problem.track_id = session[:track_id]
		@problem.snippet = problem_params_add[:snippet]
		if lecturer_signed_in?
			@problem.owner_id = current_lecturer.id
			@problem.owner_type = "lecturer"
		elsif teaching_assistant_signed_in?
			@problem.owner_id = current_teaching_assistant.id
			@problem.owner_type = "teaching assistant"
		end
		@problem.incomplete = true
		begin
			if @problem.save
				redirect_to :controller => "test_cases", :action => "new",
					:problem_id => @problem.id, :track_id => session[:track_id], :flag => "0"
			else
				render :action => 'new', :locals => {:track_id => session[:track_id]}
			end
		rescue
			render :action => 'new', :locals => {:track_id => session[:track_id]}
		end
	end

	# [Edit Problem - 4.5]
	# Shows the problem's title and description (Further development is in Sprint 1)
	# Parameters:
	#	problem_id: The id of the problem to be edited or newly created
	#	topic_id: The id of the topic contains the problem
	# Returns:
	#	Redirects to edit page on success, refreshes on failure
	# Author: Abdullrahman Elhusseny + Ahmed Osam
	def edit
		if lecturer_signed_in? || teaching_assistant_signed_in?
			@session = {}
			@session[:problem_id] = params[:id] || params[:problem_id]
			@problem = Problem.find_by_id(@session[:problem_id])
			@track = @problem.track
			params[:track_id] = @track.id
			@topic = @track.topic
			@tracks = @topic.tracks
			params[:model_answer_id] = @problem.model_answers.first.id
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
	# Author: Abdullrahman Elhusseny + Ahmed Osam
	def new
		if lecturer_signed_in? || teaching_assistant_signed_in?
			session[:track_id] = params[:id]
			@problem = Problem.new
			if session[:track_id].blank?
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
	#	params[:problem_id]: The current problem's id
	# Returns: 
	#	flash[:notice]: A message indicating the success of the deletion
	# Author: Ahmed Atef + Ahmed Osam
	def destroy
		@problem = Problem.find_by_id(params[:problem_id])
		@track = @problem.track_id
		if @problem.destroy
			flash[:notice] = "Problem successfully Deleted"
			redirect_to(:controller => 'tracks',
				:action => 'show', :id => @track)
		end
	end

	# [Edit Problem - 4.5]
	# Update the problem's title, description or track
	# Parameters:
	#	problem_params: a problem's title, description & track_id
	# Returns:
	#	Refreshes divisions in the page using AJAX without refreshing the whole page
	# Author: Abdullrahman Elhusseny + Rami Khalil + Ahmed Osam
	def update
		@problem = Problem.find_by_id(session[:problem_id])
		@track = Track.find_by_id(@problem.track_id)
		@tracks = Track.where(topic_id: @track.topic_id)
		if problem_params[:title] != @problem.title
			@message = "Title updated"
		elsif problem_params[:description] != @problem.description
			@message = "Description updated"
		elsif problem_params[:track_id].to_i != @problem.track_id
			@message = "Problem has moved to Track #{problem_params[:track_id]}"
		elsif problem_params[:snippet] != @problem.snippet
			@message = "Snippet has changed"
		elsif problem_params[:title] == @problem.title &&
			problem_params[:description] == @problem.description &&
			problem_params[:track_id].to_i == @problem.track_id &&
			problem_params[:snippet] == @problem.snippet
			flash[:notice] = "You have entered the same paramater no change has been made!"
		else
			flash[:notice] = "You have entered an empty paramater no change has been made!"
		end

		if problem_params[:track_id].to_i == @problem.track_id
			if problem_params[:title] != @problem.title ||
				problem_params[:description] != @problem.description ||
				problem_params[:snippet] != @problem.snippet
				begin
					if @problem.update_attributes(problem_params)
						flash[:notice] = @message
						respond_to do |format|
							format.js
							format.html {redirect_to :action => "edit", :format => :js, 
								:problem_id => @problem.id, :track_id => session[:track_id]}
						end
					else
						@problem = Problem.find_by_id(params[:problem_id])
						respond_to do |format|
							format.js
							format.html {redirect_to :action => "edit", :format => :js, 
								:problem_id => @problem.id, :track_id => session[:track_id]}
						end
					end
				rescue
					@problem = Problem.find_by_id(params[:problem_id])
					respond_to do |format|
						format.js
						format.html {redirect_to :action => "edit", :format => :js,
							:problem_id => @problem.id, :track_id => session[:track_id]}
					end
				end
			end
		else
			@track = Track.find_by_id(problem_params[:track_id])
			@problems_in_track = @track.problems.where(title: @problem.title)
			if @problems_in_track.size == 0
				if @problem.update_attributes(problem_params)
					flash[:notice] = @message
					respond_to do |format|
						format.js
						format.html {redirect_to :action => "edit", :format => :js,
							:problem_id => @problem.id, :track_id => session[:track_id]}
					end
				end
			else
				flash[:notice] = "#{@track.title} has a problem with the same title"
				@track = Track.find_by_id(@problem.track_id)
				respond_to do |format|
					format.html {redirect_to :action => "edit",
						:problem_id => @problem.id, :track_id => session[:track_id]}
					format.js
				end
			end
		end
	end

	# [Edit Problem - 4.5]
	# Checks if problem is complete or not by checking the number of test cases and answers
	# Parameters:
	#	problem_id: ID of the problem being edited
	#	flag: identification flag to decide between add or editing.	
	# Returns:
	#	On success redirects to the track page, on failure redirects to the edit page
	# Author: Abdullrahman Elhusseny + Ahmed Osam
	def done
		@problem = Problem.find_by_id(params[:problem_id])
		session[:track_id] = params[:track_id]
		session[:model_answer_id] = params[:model_answer_id]
		if @problem.model_answers.empty? || @problem.test_cases.empty?
			flash[:notice] = "Problem is incomplete,
			please add necessary at least 1or save as incomplete"
		else
			@problem.incomplete = false
			@problem.save
		end
		redirect_to :controller => 'tips', :action => 'new',
			:model_answer_id => params[:model_answer_id],
			:track_id => session[:track_id], :flag => "0"
	end

	# [Add Problem - 4.4]
	# Passes the input of the form as paramaters for create action to use it
	# Parameters: none
	# Returns:
	#	Filtered parameter list for problems
	# Author: Abdullrahman Elhusseny + Rami Khalil + Ahmed Osam
	private
		def problem_params
			params.require(:Problem).permit(:title, :description, :track_id, :snippet)
		end

	# [Add/Edit wizard - Story 1.28 ]
	# Description:
	#	take the parameters from the from
	# Parameters: none
	# Returns:
	#	Hash of paramas
	# Author: Ahmed Osam
		def problem_params_add
			params.require(:problem).permit(:title, :description, :track_id, :snippet)
		end

end