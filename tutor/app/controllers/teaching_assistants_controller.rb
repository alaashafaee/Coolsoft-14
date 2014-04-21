class TeachingAssistantsController < ApplicationController

	def new 

	end

	def create
		@teaching_assistant = teaching_assistants.where(email: params[:email])
		@course = courses.find_by_id(params[:course_id])
	end	
	

	def index
		@course = Course.find(params[:course_id])
		@teaching_assistants = @course.TAs.order('name')
	end








end
