class TipsController < ApplicationController
# [View hints and tips]
# It fetches from database all the previous tips.
# Parameters: 
#   @tips: All the previous tips that had been entered before.
#   Return : none
# Author: Nadine Adel
	def new
		@tips= Hint.all
	end
end