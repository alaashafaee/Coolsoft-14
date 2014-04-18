class TopicsController < ApplicationController

	# [Specify Topics - Story 1.2]
	# Description: This action takes the passed course id and assings
	#              the respective course to an instance variable.
	# Parameters:
	#	params[:course_id]: The current course id
	# Returns: 
	# 	none
	# Author: Ahmed Akram
	def new
		@course = Course.find(params[:course_id])
		@new_topic = Topic.new
	end


	# [Specify Topics - Story 1.2]
	# Description: This action takes the passed course id and assings
	#              the respective topics of that course to an instance
	#              variable.
	# Parameters:
	#	params[:id]: The current course id
	# Returns: 
	# 	@topics: A list of all topics belonging to the course
	# Author: Ahmed Akram
	def index
		@course = Course.find(params[:course_id])
		@topics = @course.topics.order("created_at desc")
	end

	# [Specify Topics - Story 1.2]
	# Description: This action takes the passed parameters from 
	#              the creation form, creates a new Topic record
	#              and assigns it to the respective course. If the 
	#              creation fails the user is redirected to the form
	#              with a "Failed" message.
	# Parameters:
	#	topic_params[]: A list that has all fields entered by the user to in the
	# 					create_topic_form
	# Returns: 
	# 	flash[:notice]: A message indicating the success or failure of the creation
	# Author: Ahmed Akram
	def create
		@new_topic = Topic.new
		@new_topic.title = topic_params[:title]
		@new_topic.description = topic_params[:description]
		bool = @new_topic.save
		if bool == true 
			flash[:notice] = "Topic successfully created"
			@course = Course.find(course_params[:course_id])
			@course.topics << @new_topic
			redirect_to :action => 'index'
		else
			if @new_topic.errors.any?
				flash[:notice] = @new_topic.errors.full_messages.first
			end
			render :action => 'new'  
		end
	end

	# [Specify Topics - Story 1.2]
	# Description: This action shows the topics of the selected course
	# Parameters:
	#	params[:id]: The current selected topic
	# Returns: 
	# 	@topic: An instance variable of the topic
	# Author: Ahmed Akram
	def show
		@topic = Topic.find_by_id(params[:id])
	end

	private
		def topic_params
			params.require(:topic).permit(:title,:description)
		end

		def course_params
			params.permit(:course_id)
		end

end