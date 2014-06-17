class ResourcesController < ApplicationController
	before_action :authenticate_lecturer!, except: [:index]

	# [Course Resources - Story 1.25]
	# Initialize resource
	# Parameters: none
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
	# Parameters:
	# 	  hash of the resources attributes
	# Returns: redirect to course resources page
	# Author: Ahmed Elassuty
	def create
		@course = Course.find_by_id(params[:course_id])
		unless params[:course].nil?
			params[:course][:resources_attributes].each do |f|
				link_body = f[1][:link]
				unless link_body.nil?
					if link_body.empty?
						unless f[1][:id].nil?
							Resource.find(f[1][:id]).destroy
						end
					else
						begin
							page = MetaInspector.new(link_body,
								:allow_redirections => :all, :timeout => 50)
							type = page.content_type
							url = page.url.chomp("\/")
							title = page.meta_og_title || page.title
							description = (type.eql? "application/pdf") ? nil : page.description
							images = page.images.slice!(0,8)
							images.insert(0,page.image) unless page.image.blank?
							resource = { link: url, description: description,
								img: images.first, link_type: type }
						rescue
							flash[:notice] =
								"link #{link_body} is not valid or check your internet connection!!"
							resource = nil
						end
						unless resource.nil?
							@resource = Resource.find_by(id: f[1][:id],
								course_id: @course.id)
							if @resource.nil?
								@resource = Resource.create(resource)
								@resource.remote_img_url = resource[:img]
								@course.resources << @resource
								current_lecturer.resources << @resource
							else
								unless resource[:link].eql? @resource.link
									@resource.update_attributes(resource)
								end
							end
						end
					end
				end
			end
		end
		render action: :index
	end

	# [Course Resources - Story 1.25]
	# index resources of a course
	# Parameters:
	# 	  course_id
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
	# Parameters:
	# 	  course_id and resource_id
	# Returns: no return
	# Author: Ahmed Elassuty
	def destroy
		@resource = Resource.find_by(id: params[:id],course_id: params[:course_id])
		unless @resource.nil?
			if @resource.destroy
				render nothing:true, status: :ok
				return
			end
		end
		render nothing:true, status: :not_found
	end

end