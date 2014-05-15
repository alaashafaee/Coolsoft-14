class ContestsController < ApplicationController

	# [Contest Standings - Story 5.25]
	# Returns the contest object whose id is params[:id]
	# Parameters: none
	# Returns: none
	# Author: Mohab Ghanim
	def standings
		@contest = Contest.find_by_id(params[:id])
	end

	
end
