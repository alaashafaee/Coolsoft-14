class HintsController < ApplicationController
# [View hints and tips]
# It fetches from database all the previous hints.
# Parameters: 
#   @hints: All the previous hints that had been entered before.
#   @hints: All the previous hints that had been entered before to check if it is a hint or a tip.
#   Return : none
# Author: Nadine Adel
	def new
		@hints = Hint.all
		@hints_check=Hint.all
	end
end