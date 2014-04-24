class HintsController < ApplicationController
  	# [View hints and tips-Story 4.22]
	# It fetches from database all the previous hints.
	# Parameters: 
	#   @hints: All the previous hints that had been entered before.
	#   @hints_check: All the previous hints that had been entered before to check if it is a hint or a tip.
	# Return : table with all previous hints
	# Author: Nadine Adel
	def index
		@hints = Hint.all
		@hints_check = Hint.all
	end
end
