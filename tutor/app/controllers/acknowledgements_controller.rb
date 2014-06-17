class AcknowledgementsController < ApplicationController
	# [Student Acknowledgement - Story 1.7]
	# Description: This action takes the passed course id and assings
	#              the respective course to an instance variable.
	# Parameters:
	#	params[:course_id]: The current course id
	# Returns: none
	# Author: Muhammad Mamdouh
	def new 
		@course = Course.find(params[:course_id])
		if !@course.can_edit(current_lecturer)
			redirect_to :root
		end
	end

	# [Student Acknowledgement - Story 1.7]
	# Description: This action takes the passed parameters from 
	#              the creation form, creates a new acknowledgement record
	#              and assigns it to the respective course. If the 
	#              creation fails the user is redirected to the form
	#              with an appropriate message.
	# Parameters:
	#	array "students" which has the students selected
	#	the ID of the course
	#	the description of the acknowledgement.
	# Returns: A message indicating the success or failure of the creation
	# Author: Muhammad Mamdouh + Ahmed mohamed magdi
	def create
		status = []
		students = params[:students].to_a
		if params[:students] != nil
			students.each do |student|
				puts(student.to_i)
				@student = Student.find_by_id(student.to_i)
				@course = Course.find_by_id(params[:course_id])
				@acknowledgement = Acknowledgement.new
				@acknowledgement.message = params[:description]
				if @acknowledgement.save
					if @student != nil
						@student.acknowledgements << @acknowledgement
						current_lecturer.acknowledgements << @acknowledgement
						@course.acknowledgements << @acknowledgement
						status << true
						Notification.acknowledgement_notify(@student.id, current_lecturer.id, 
							@acknowledgement.id)
					end
				end
			end	
		end
		pass = true
		status.each do |state|
			unless state
				pass = false
			end
		end
		if pass
			render json: @acknowledgement
		else
			render false
		end
	end

end