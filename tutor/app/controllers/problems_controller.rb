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
		p = Problem.new(permitCreate)
		if lecturer_signed_in?
			p.owner_id = current_lecturer.id
			p.owner_type = "lecturer"
		elsif teaching_assistant_signed_in?
			p.owner_id = current_teaching_assistant.id
			p.owner_type = "teaching assistant"
		end
		if p.save
			redirect_to :action => "edit", :id => p.id
		else 
			flash.keep[:notice] = "Problem is missing paramaters"
			redirect_to :back
		end
	end

	# [Add Problem - 4.4]
	# Passes the input of the form as paramaters for create action to use it
	# Parameters:
	#   title: problem's title
	#   description: problem's description
	# Returns: params to create action
	# Author: Abdullrahman Elhusseny
	def permitCreate
		params.require(:Problem).permit(:title , :description)
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
				redirect_to(:controller => 'tracks' , :action => 'show' ,:id => @track)
			end
	end
end