class AcknowledgementsController < ApplicationController

	def new 
		@course = Course.find(params[:course_id])
	end

	def create
		@student = Student.find_by_id(params[:student][:id])
		@course = Course.find_by_id(params[:course_id])
		@acknowledgement = Acknowledgement.new
		@acknowledgement.message = acknowledgement_params[:description]

	end	



















end
