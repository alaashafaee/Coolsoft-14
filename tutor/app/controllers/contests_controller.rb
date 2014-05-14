class ContestsController < ApplicationController

	# [View Contests - Stroy 5.19]
	# This action renders a list of all contests belonging to 
	#	the current user.
	# Parameters:
	#	current_lecturer: The current signed in lecturer
	#	current_teaching_assistant: The currrent signed in teaching assistant
	#	current_students: The current signed in student	
	# Returns: 
	#	@contest: A list of all the user's contests
	# Author: Muhammad Mamdouh
	def index
		if lecturer_signed_in?
			@contests = current_lecturer.contests
		elsif teaching_assistant_signed_in?
			@contests = current_teaching_assistant.contests
		elsif student_signed_in?
			@contests = current_student.contests
		end
	end

end
