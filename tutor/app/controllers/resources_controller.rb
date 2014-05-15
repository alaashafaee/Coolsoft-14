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
		begin
			@resource = Resource.new
			page = MetaInspector.new(params[:course][:resources_attributes]["0"][:link],
				:allow_redirections => :all, :timeout => 50)
			type = page.content_type
			puts type
			puts "------------------"
			title = page.meta_og_title || page.title
			description = type.eql? "application/pdf" ? nil : page.description
			images = page.images.slice!(0,8)
			images.insert(0,page.image) unless page.image.blank?
			puts images.first
			puts "-------------"
			@resource.remote_img_url = images.first
			@resource.link = page.url
			@resource.description = description
			@course.resources << @resource
			puts @resource.inspect
			puts "---------------------"
		rescue
			redirect_to :back
		end
		# @course.update_attributes(resources_attributes: params[:course][:resources_attributes])
		if @resource.save
			render nothing:true
		end
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