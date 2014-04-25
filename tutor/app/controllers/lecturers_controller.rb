class LecturersController < ApplicationController
	# [Profile - Story 5.8]
	# Displays the profile of the lecturer chosen
	# Parameters:
	#	id: the Lecturer's id
	# Returns: none
	# Author: Serag
	def show
		@lecturer = Lecturer.find(params[:id])
		@courses = @lecturer.courses.order("created_at desc")
	end
end