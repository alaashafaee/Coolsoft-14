class TopicsController < ApplicationController

	# [Create Track - Story 4.1]
	# Shows the tracks of the topic with id :id or
	# Shows 404 page if there is no topic with such id
	# This Action should be put in the future in the 
	# Topic controller
	# Parameters: 
	#	id: The id of the topic
	# Returns: The view of the requested topic
	# Author: Mussab ElDash
	def show
		id = params[:id]
		@topic = Topic.find_by_id(id)
		if @topic
			@course = @topic.course
			@tracks = @topic.tracks
			@can_edit = @course.can_edit(current_lecturer, current_teaching_assistant)
		else
			render ('public/404')
		end
	end

	# [Specify Topics - Story 1.2]
	# Description: This action takes the passed course id and assings
	#	the respective course to an instance variable.
	# Parameters:
	#	params[:course_id]: The current course id
	# Returns: none
	# Author: Ahmed Akram
	def new
		@course = Course.find(params[:course_id])
		if !@course.can_edit(current_lecturer)
			redirect_to :root
		end
		@new_topic = Topic.new
	end

	# [Delete Topic - Story 1.34]
	# This action takes the topic id, remove it from the database
	#	and then redirects the user to the show courses page accompanied
	#	with a "Topic deleted" message.
	# Parameters:
	#	params[:id]: The current topic's id
	# Returns: none
	# Author: Mohamed Saeed
	def destroy
		topic = Topic.find_by_id(params[:id])
		topic.destroy
		flash[:success_deletion] = "Topic deleted."
		@course = topic.course
		redirect_to :controller => 'courses', :action => 'show', :id => @course.id
	end

	# [Specify Topics - Story 1.2]
	# Description: This action takes the passed course id and assings
	#	the respective topics of that course to an instance
	#	variable.
	# Parameters:
	#	params[:id]: The current course id
	# Returns: 
	#	@topics: A list of all topics belonging to the course
	# Author: Ahmed Akram
	def index
		@course = Course.find(params[:course_id])
		@topics = @course.topics
	end

	# [Specify Topics - Story 1.2]
	# Description: This action takes the passed parameters from 
	#	the creation form, creates a new Topic record
	#	and assigns it to the respective course. If the 
	#	creation fails the user is redirected to the form
	#	with a "Failed" message.
	# Parameters:
	#	topic_params[]: A list that has all fields entered by the user to in the
	#					create_topic_form
	# Returns: 
	#	flash[:notice]: A message indicating the success or failure of the creation
	# Author: Ahmed Akram + Mohamed Saeed
	def create
		@new_topic = Topic.new
		@new_topic.title = topic_params[:title]
		@new_topic.description = topic_params[:description]
		bool = @new_topic.save
		if bool == true
			flash[:notice] = "Topic successfully created"
			@course = Course.find(course_params[:course_id])
			@course.topics << @new_topic
			redirect_to :controller => 'courses', :action => 'show', :id => course_params[:course_id]
			Topic.update_track_progression @new_topic
		else
			if @new_topic.errors.any?
				flash[:notice] = @new_topic.errors.full_messages.first
			end
			render :action => 'new'
		end
	end

	# [Edit Track Rating - Story 4.3]
	# Changes the difficulty of tracks that belong to a certain topic  
	#	to match the order specified by TA/Lecturer through 
	#	drag and drop sortable list. 
	# Parameters: 
	#	params[:methodParam]: The array of the sorted trackes.
	# Returns: none
	# Author: Lin Kassem
	def sort
		tracks = Track.find_by_id(params[:methodParam][0]).topic.tracks
		tracks.each do |track|
			track.difficulty = -1
			track.save
		end
		tracks.each do |track|
			track.difficulty = (params[:methodParam]).index(track.id.to_s)
			track.save
		end
		render :nothing => true
	end

	private
		def topic_params
			params.require(:topic).permit(:title,:description)
		end

		def course_params
			params.permit(:course_id )
		end

		def track_params
			params.permit(:difficulty)
		end

end
