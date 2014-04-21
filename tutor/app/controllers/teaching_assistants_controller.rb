class TeachingAssistantsController < ApplicationController

	def new 

	end

	def create
		@teaching_assistant = TeachingAssistant.find_by_id(params[:teaching_assistant][:id])
		@course = Course.find_by_id(params[:course_id])
		@course.TAs << @teaching_assistant
		redirect_to :action => 'index'
	end	
	

	def index
		@course = Course.find(params[:course_id])
		@course_teaching_assistants = @course.TAs.order('name')
	end








end
