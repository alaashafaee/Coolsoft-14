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
	# [Adding Helping Hints - 4.12]
	# Creates a new record to Hint Table
	# Parameters:
	#   owner_id: ID of the hint owner
	#   owner type: type of hint owner
	# Returns: Redirects to edit page on success, refreshes on failure
	# Author: Mohamed Fadel
	def create
		p = Hint.new(permitCreate)
		if lecturer_signed_in?
			p.owner_id = current_lecturer.id
			p.owner_type = "lecturer"
		else
			p.owner_id = current_teaching_assistant.id
			p.owner_type = "teaching_assistant"
		end

		if p.save
			redirect_to :action => "new", :id => p.id
		else 
			flash.keep[:notice] = "Hint is missing paramaters"
			redirect_to :back
		end
	end

	# [Adding Helping Hints - 4.12]
	# Passes the input of the form as paramaters for create action to use it
	# Parameters:
	#   category: hint's category
	#   submission_counter: hint's submission counter
	#   message: hint's message
	# Returns: params to create action
	# Author: Mohamed Fadel
	def permitCreate
		params.require(:Hint).permit(:category, :submission_counter, :message)
	end
	def create_new
	end	
end