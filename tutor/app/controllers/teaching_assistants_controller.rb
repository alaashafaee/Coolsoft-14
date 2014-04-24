class TeachingAssistantsController < ApplicationController

	# [Add TA - Story 1.4]
	# this action renders the form and sets the value for checkbox
	# Parameters: 
	#   check : contains the value from the previous instance of the form
	# Returns: None
	# Author: Muhammad Mamdouh
	def new 
		if @checkbox == nil
			@checkbox = true
		end
		@checkbox = !params[:check]
	end

	# [Add TA - Story 1.4,1.5,1.6]
	# Adds the TA selected from the dropdown list in the view to the course and to the lecturer's history
	# Parameters: teaching_assistant_id , course_id
	# Returns: flash[:notice] that shows the result of trying to add the TA
	# Author: Muhammad Mamdouh
	def create
		begin
			@teaching_assistant = TeachingAssistant.find_by_id(params[:teaching_assistant][:id])
			if params[:teaching_assistant][:id] == ''
 				flash[:notice] = 'Error! you need to select a TA'
				redirect_to :action => 'new'
			else
				@course = Course.find_by_id(params[:course_id])
				@course.TAs << @teaching_assistant
				flash[:notice]='TA added!'
				@notification = NotificationMail.new
				@notification.subject = 'Invitation to join tutor'
				@notification.email = @teaching_assistant.email
				@notification.content = 'You have been added to a course on Tutor!' 
				@notification.save
				redirect_to :action => 'index'
			end
		rescue
			flash[:notice]='Error! TA is already added to the course.'
			redirect_to :action => 'new'
		end	
	end

	# [Add TA - Story 1.4, 1.5, 1.6]
	# lists the TAs added to the course.
	# Parameters: course_id
	# Returns:
	# @course
	# @course_teaching_assistants
	# Author: Muhammad Mamdouh	
	def index
		@course = Course.find(params[:course_id])
		@course_teaching_assistants = @course.TAs.order('name')
	end

end