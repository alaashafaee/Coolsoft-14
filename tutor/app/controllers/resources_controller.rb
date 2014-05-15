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
		params[:course][:resources_attributes].each do |f|
			link_body = f[1][:link]
			unless link_body.nil?
				if link_body.empty?
					Resource.find(f[1][:id]).destroy
				else
					resource = inspect(link_body)
					unless resource.nil?
						@resource = Resource.find_by(link: resource[:link], course_id: @course.id)
						if @resource.nil?
							@course.resources.build(resource)
						else
							@resource.update_attributes(resource)
						end
					end
				end
			end
		end
		if @course.save
			render action: :index
		end
					# @resource = Resource.new
					# @resource.remote_img_url = images.first
					# @resource.link = page.url
					# @resource.description = description
					# @course.resources << @resource
					# puts @resource.inspect
		# @course.update_attributes(resources_attributes: params[:course][:resources_attributes])
		# unless @resource.nil?
		# 	if @resource.save
		# 		render nothing:true
		# 	end
		# end
	end

	# [Course Resources - Story 1.25]
	# index resources of a course
	# Parameters: course_id
	# Returns: course resources
	# Author: Ahmed Elassuty
	def index
		@course = Course.find(params[:course_id])
		respond_to do |format|
			format.html
		end
	end

	# [Course Resources - Story 1.25]
	# remove resource
	# Parameters: course_id and resource_id
	# Returns: no return
	# Author: Ahmed Elassuty
	def destroy
		@resource = Resource.find_by(id: params[:id],course_id: params[:course_id])
		if @resource.destroy
			render nothing:true
		end
	end

	private
		def inspect(link)
			begin
				page = MetaInspector.new(link,
					:allow_redirections => :all, :timeout => 50)
				type = page.content_type
				url = page.url.chomp("\/")
				title = page.meta_og_title || page.title
				description = (type.eql? "application/pdf") ? nil : page.description
				images = page.images.slice!(0,8)
				images.insert(0,page.image) unless page.image.blank?
				{ link: url, description: description, img: images[0], link_type: type }
			rescue
				nil
			end
		end

end