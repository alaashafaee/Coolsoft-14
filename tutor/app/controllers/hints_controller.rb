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
		new_hint = Hint.new(permitCreate)
		if lecturer_signed_in?
			current_lecturer.hints << new_hint
			new_hint.category = false
			new_hint.model_answer_id = @@answer_id
		else
			current_teaching_assistant.hints << new_hint
			new_hint.category = false
			new_hint.model_answer_id = @@answer_id
		end
		if new_hint.save
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
	private
	def permitCreate
		params.require(:Hint).permit(:submission_counter, :message)
		
	end
end