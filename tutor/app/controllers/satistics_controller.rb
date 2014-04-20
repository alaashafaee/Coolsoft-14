class SatisticsController < ApplicationController
	# [number_of_problems_answered_correctly - Story 2.1]
	# Select all problems which have success_attempts greater than zero and count the records
	# Parameters: 
	# 		success_attempts=an intger value that shows how many times does the problem have to be answered correctly
	# Returns: an integer value 
	# Returns in case of failure : a message "No problem is answered correctly"
	# Author: Rana ElNagar
  	def show
  		@problems = Problem.count(:success_attempts).where.not(:success_attempts = 0)
  		if @problems.nil?
  			render "no problem is answered correctly"
  		else 
  			redirect :action => "show"
 	end
end
