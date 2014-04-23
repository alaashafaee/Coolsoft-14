class AcknowledgementsController < ApplicationController
	# [Student Acknowledgement - Story 1.7]
	# Description: This action takes the passed course id and assings
	#              the respective course to an instance variable.
	# Parameters:
	#	params[:course_id]: The current course id
	# Returns: 
	# 	none
	# Author: Muhammad Mamdouh
	def new 
		@course = Course.find(params[:course_id])
	end

	# [Student Acknowledgement - Story 1.7]
	# Description: This action takes the passed parameters from 
	#              the creation form, creates a new acknowledgement record
	#              and assigns it to the respective course. If the 
	#              creation fails the user is redirected to the form
	#              with an appropriate message.
	# Parameters:
	# 	array "students" which has the students selected
	# 	the ID of the course
	# 	the description of the acknowledgement.
	# Returns: 
	# 	flash[:notice]: A message indicating the success or failure of the creation
	# Author: Muhammad Mamdouh
	def create
		params[:students].each do |student|
			@student = Student.find_by_id(student)
			@course = Course.find_by_id(params[:course_id])
			@acknowledgement = Acknowledgement.new
			@acknowledgement.message = params[:acknowledgement][:description]
			bool = @acknowledgement.save
			if bool == true
				if @student == nil
					flash[:notice]= "Please choose a student to acknowledge."
				else
				flash[:notice] = "Acknowledgement successfully created"
				@student.acknowledgements << @acknowledgement
				current_lecturer.acknowledgements << @acknowledgement
				@course.acknowledgements << @acknowledgement
				end
			else
				flash[:notice] = "Acknowledgement failed."
			end
		end	
		redirect_to :action => 'new'
	end
end