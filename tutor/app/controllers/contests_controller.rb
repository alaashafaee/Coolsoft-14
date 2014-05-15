class ContestsController < ApplicationController

	# [View Contest Problems - Story 5.26]
	# Description: Displays the contest that the user chose
	# Parameters:
	#	@contest: The contest id that the user chose
	#	@problems = The list of problems of @contest
	# Returns: The view of the contest
	# Author: Ahmed Atef
	def show
		@contest = Contest.find(params[:id])
		@problems =  @contest.problems.all
	end
	
end
