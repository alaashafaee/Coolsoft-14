class TracksController < ApplicationController
	
	# [Create Track - Story 4.1]
	# shows the tracks of the topic with id :id
	# show 404 page if there is no topic with such id
	# This Action should be put in the future in the 
	# Topic controller
	# Parameters: 
	#   id: The id of the topic
	# Returns: The view of the requested topic
	# Author: Mussab ElDash
	def show
		boool = flash[:notice] != "Successfully created..."
		boool&&=flash[:notice] != "The required Fields are missing"
		if boool
			flash[:notice]= nil
		end
		id = params[:id]
		@topic = Topic.find_by_id(id)
		if @topic
			@course = @topic.course
			@tracks = @topic.tracks
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
  		t = Track.new(permitCreate)
  		if t.save
  			flash[:notice] = "Successfully created..."
  			redirect_to :back
		else
			flash[:notice] = "The required Fields are missing"
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
	def permitCreate
		params.require(:Track).permit(:topic_id , :title , :difficulty)
	end
end