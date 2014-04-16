class CoursesController < ApplicationController
	
	# [view courses - Story 1.11]
	# Returns table IFF there is courses created by the user "Lecturer".
	# Parameters: @courses array of courses created by the lecturer.
	# user_id: Lecturer's ID
	# Returns: A table containing Lecturer courses.
	# Author: Ahmed Osam
	def index
		@courses = current_lecturer.courses.order("created_at desc")
	end
	
end