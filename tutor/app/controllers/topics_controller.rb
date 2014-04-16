class TopicsController < ApplicationController

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
		id = params[:id]
		@topic = Topic.find_by_id(id)
		if @topic
			@course = @topic.course
			@tracks = @topic.tracks
			@can_edit = @course.can_edit(current_lecturer)
			@can_edit||= @course.can_edit(current_teaching_assistant)
		else
			render ('public/404')
		end
	end
end