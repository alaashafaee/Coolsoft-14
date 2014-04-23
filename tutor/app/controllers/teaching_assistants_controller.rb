class TeachingAssistantsController < ApplicationController
	# [Profile - Story 5.8]
	# Displays the profile of the teaching assistant chosen
	# Parameters:
	#	id: the Teaching Assistant's id
	# Returns: none
	# Author: Serag
	def show
		@teaching_assistant = TeachingAssistant.find(params[:id])
		@courses = @teaching_assistant.courses.order("created_at desc")
	end
end