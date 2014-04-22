class TeachingAssistantsController < ApplicationController

	def new 
		@course = Course.find_by_id(params[:course_id])
	end

	def create
		begin
			@teaching_assistant = TeachingAssistant.find_by_id(params[:teaching_assistant][:id])
			@course = Course.find_by_id(params[:course_id])
			@course.TAs << @teaching_assistant
			current_lecturer.worked_with << @teaching_assistant
			flash[:notice]='TA added!'
			redirect_to :action => 'index'
		rescue
			flash[:notice]='TA is already added to the course'
			redirect_to :action => 'new'
		end	


	end	
	

	def index
		@course = Course.find(params[:course_id])
		@course_teaching_assistants = @course.TAs.order('name')
	end








end
