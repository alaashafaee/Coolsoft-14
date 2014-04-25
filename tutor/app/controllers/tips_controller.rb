class TipsController < ApplicationController
 	# [View hints and tips-Story 4.22]
	# It fetches from database all the previous tips.
	# Parameters:
	#	@tips: All the previous tips that had been entered before.
	#	@tips_check:All the previous tips that had been entered before to check if it is a tip or hint.
	# Returns : none.
	# Author: Nadine Adel
	def index
		@tips= Hint.all
		@tips_check = Hint.all
		#User.where(["name = ? and email = ?", "Joe", "joe@example.com"])
	end
end
