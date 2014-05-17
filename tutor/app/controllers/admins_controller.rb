class AdminsController < ApplicationController
	# Verify lecturers and TAs #176
	# select all lecturers who aren't verified, verified_type=false
	# Parameters: 
	#   verified_type: a boolean variable to check if the lecturer is verified 
	# Returns: All lecturers who are not verified
	# Author: Rana ElNagar
	def allLecturers
		@lecturers = Lecturer.find_by verified_type : false
	end

	# Verify lecturers and TAs #176
	# select all TAs who aren't verified, verified_type=false
	# Parameters: 
	#   verified_type: a boolean variable to check if the TA is verified 
	# Returns: All TAs who are not verified
	# Author: Rana ElNagar
	def allTAs
		@TAs = Teaching_assistant.find_by verified_type : false
	end

	# Verify lecturers and TAs #176
	# change the verified_type of the TA to true
	# Parameters:
	#   id : a unique number for every record in teaching_assistants table
	#   verified_type: a boolean variable to check if the TA is verified 
	# Returns: change the verified_type of the TA to true
	# Author: Rana ElNagar
	def approveRequestsTA
		@teaching_assistant= Teaching_assistant.find_by_id(params[:id])
		@teaching_assistant.verified_type=true
		@teaching_assistant.save
	end

	# Verify lecturers and TAs #176
	# change the verified_type of the lecturer to true
	# Parameters:
	#   id : a unique number for every record in lecturer table
	#   verified_type: a boolean variable to check if the TA is verified 
	# Returns: change the verified_type of the lecturer to true
	# Author: Rana ElNagar
	def approveRequestsLecturer
		@lecturer=Lecturer.find_by_id(params[:id])
		@lecturer.verified_type=true
		@lecturer.save
	end

end
