module ApplicationHelper
	
	# [Simple Search - Story 1.22]
	# helper to handle ajax search
	# Parameters: string controller
	# Returns: boolean if the requested controller equals the passed one
	# Author: Ahmed Elassuty
	def controller?(controller)
		params[:controller].include?controller
	end
end
