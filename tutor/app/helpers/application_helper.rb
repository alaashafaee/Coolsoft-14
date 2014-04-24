module ApplicationHelper
	
	# [Simple Search - Story 1.22]
	# helper to handle ajax search
	# Parameters: string controller, string action
	# Returns: boolean if the requested controller equals the passed one and also the action
	# Author: Ahmed Elassuty
	def controller?(controller,action)
		params[:controller].include?controller and params[:action].include?action
	end
end
