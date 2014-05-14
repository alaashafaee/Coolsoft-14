class ResourcesController < ApplicationController

	# [Course Resources - Story 1.25]
	# Initialize resource
	# Parameters: no parameters
	# Returns: New Resource object
	# Author: Ahmed Elassuty
	def new
		@course = Course.find_by_id(params[:course_id])
		respond_to do |format|
			format.html
		end
	end

	# [Course Resources - Story 1.25]
	# add resources to a course
	# Parameters: hash of the resources attributes
	# Returns: redirect to course resources page
	# Author: Ahmed Elassuty
	def create
		@course = Course.find_by_id(params[:course_id])
		@course.update_attributes(resources_attributes: params[:course][:resources_attributes])
		render nothing:true
	end

	# [Course Resources - Story 1.25]
	# index resources of a course
	# Parameters: course_id
	# Returns: course resources
	# Author: Ahmed Elassuty
	def index
	end

	# [Course Resources - Story 1.25]
	# index resources of a course
	# Parameters: course_id
	# Returns: course resources
	# Author: Ahmed Elassuty
	def add_more
		@course = Course.find(params[:course_id])
		respond_to do |format|
			format.js
		end
	end

end