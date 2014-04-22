class HintsController < ApplicationController

	@@answer_id = nil

	# [Adding Helping Hints - 4.12]
	# Creates a new record to Hint Table
	# Parameters:
	#	owner_id: ID of the hint owner
	#	owner type: type of hint owner
	#	category: states whether it is a hint or tip
	# Returns:
	#	Redirects to edit page on success, refreshes on failure
	# Author: Mohamed Fadel
	def create
		p = Hint.new(permitCreate)
		if lecturer_signed_in?
			p.owner_id = current_lecturer.id
			p.owner_type = "lecturer"
			p.category = false
			p.model_answer_id = @@answer_id
		else
			p.owner_id = current_teaching_assistant.id
			p.owner_type = "teaching_assistant"
			p.category = false
			p.model_answer_id = @@answer_id
		end

		if p.save
			redirect_to :controller => 'model_answers', :action => 'edit', :id => @@answer_id
		else 
			flash.keep[:notice] = "Hint is missing paramaters"
			redirect_to :back
		end
	end

	# [Adding Helping Hints - 4.12]
	# Passes the input of the form as paramaters for create action to use it
	# Parameters:
	#	submission_counter: hint's submission counter
	#	message: hint's message
	# Returns: 
	#	params to create action
	# Author: Mohamed Fadel
	def permitCreate
		params.require(:Hint).permit(:submission_counter, :message)
	end
	
	# [Delete a Hint - Story 4.21]
	# This action takes the hint id, removes it from the database
	# and then redirects the user to the edit page accompanied
	# with a "Hint deleted" message.
	# Parameters:
	#	params[:id]: The current hint's id
	# Returns: 
	#	none
	# Author: Mohamed Fadel
	def destroy
		hint = Hint.find_by_id(params[:id])
		hint.destroy
		flash[:success_deletion] = "Hint deleted."
		redirect_to :controller => 'model_answers', :action => 'edit', :id => @@answer_id
	end
end