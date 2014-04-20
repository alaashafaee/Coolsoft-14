class TracksController < ApplicationController

	# [Integrating_Akram_Device - Story 4.1]
	# Shows a list of problems for the track with id :id
	# Parameters: 
	#   id: The id of the Track
	# Returns: Page with list of the problems
	# Author: Mussab ElDash

	def index
		@tracks= Track.all
	end

	def show
		id = params[:id]
		track = Track.find_by_id(id)
		if track
			@topic = track.topic
			@course = @topic.course
			@problems = track.problems
			@can_edit = @course.can_edit(current_lecturer)
			@can_edit||= @course.can_edit(current_teaching_assistant)
			if student_signed_in?
				@problems_status = current_student.getProblemsStatus
				@problems_status[:success] = @problems_status[:success] & @problems
				@problems_status[:failure] = @problems_status[:failure] & @problems
				@problems_status[:other] = @problems_status[:other] & @problems
			end
		else
			render ('public/404')
		end
	end

	# [Create Track - Story 4.1]
	# render a json file with a set of problems of the track with id :id
	# Parameters: 
	#   id: The id of the Track
	# Returns: The list of the requested problems in json file
	# Author: Mussab ElDash
	def getProblems
		id = params[:id]
		track = Track.find(id)
		problems = track.problems
		render json: problems
	end

	# [Create Track - Story 4.1]
	# creates a new track with the passed parameters
	# if the parameters is valid a flash that it was save will show
	# and if not not a flash will show that there are fields missing
	# Parameters: 
	#   topic_id: The id of the topic to connect the track to
	#   title: The title of the track to be created
	#   difficulty: The difficulty of the track to be created
	# Returns: The same page that wants to create the Track
	# Author: Mussab ElDash
	def create
		t = Track.new(permit_create)
		if t.save
			flash[:success] = "Successfully created..."
			redirect_to :back
		else
			if params[:Track][:title] == ""
				flash[:error] = "The Title field is empty"
			elsif params[:Track][:difficulty] == ""
				flash[:error] = "The Difficulty field is empty"
			else
				flash[:error] = "An error has occured"
			end
			flash[:title] = params[:Track][:title]
			flash[:difficulty] = params[:Track][:difficulty]
			redirect_to :back
		end
	end

	# [Create Track - Story 4.1]
	# permits the passed parameters
	# Parameters: 
	#   topic_id: The id of the topic to connect the track to
	#   title: The title of the track to be created
	#   difficulty: The difficulty of the track to be created
	# Returns: The permited params
	# Author: Mussab ElDash

	private
		def permit_create
			permit = params.require(:Track).permit(:topic_id, :title, :difficulty)
			topic = Topic.find_by_id(permit[:topic_id])
			if topic
				course = topic.course
			else
				return
			end
			can_edit = course.can_edit(current_lecturer)
			can_edit||= course.can_edit(current_teaching_assistant)
			if can_edit
				return permit
			end
		end
end

