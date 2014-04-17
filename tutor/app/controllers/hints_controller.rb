class HintsController < ApplicationController
# [View hints and tips]
# It fetches from database all the previous hints.
# Parameters: 
#   @hints: All the previous hints that had been entered before.
#   Return : none
# Author: Nadine Adel
	def new
		@hints = Hint.all
	end
end