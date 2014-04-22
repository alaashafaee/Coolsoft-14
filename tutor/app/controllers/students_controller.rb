class StudentsController < ApplicationController
	# [Profile - Story 5.8]
	# Displays the profile of the student chosen
	# Parameters:
	#	id: the Student's id
	# Returns: none
	# Author: Serag
	def show
		@student = Student.find(params[:id])
	end
	def index
	end
end