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
		# [Add Problem - 4.4]
	# Creates a new record to Problem Table
	# Parameters:
	#   title: problem's title through permitCreate action
	#   description: problem's description through permitCreate action
	# Returns: Redirects to edit page on success, refreshes on failure
	# Author: Abdullrahman Elhusseny
	def create
		p = Hint.new(permitCreate)

		if p.save
			redirect_to :action => "new", :id => p.id
		else 
			flash.keep[:notice] = "Hint is missing paramaters"
			redirect_to :back
		end
	end

	# [Add Problem - 4.4]
	# Passes the input of the form as paramaters for create action to use it
	# Parameters:
	#   title: problem's title
	#   description: problem's description
	# Returns: params to create action
	# Author: Abdullrahman Elhusseny
	def permitCreate
		params.require(:Hint).permit(:title , :category, :submission_counter, :message)
	end
	def create_new
	end	
end