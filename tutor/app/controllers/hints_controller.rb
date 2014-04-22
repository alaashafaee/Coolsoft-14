class HintsController < ApplicationController
	# [Edit helping hints - Story 4.13 ]
	# This action creates the form and retrives the data of the selected problem 
	#	to be being edited
	# Parameters:
	#	ID of the hint  
	# Returns: 
	#	none
	# Author: Mimi
	def edit
		@new_Tip = Hint.find_by_id(params[:id])
	end	

	# [Edit helping hints - Story 4.13 ]
	# This action takes the passed parameters from 
	#	the creation form, edits a Hint record
	#	which assigned  to the respective problem. If the 
	#	edit fails the user is redirected to the form
	#	with a "Failed" message.
	# Parameters:
	#	hint_params[]: A list that has all fields entered by the user to in the
	#		edit_hint form
	# Returns: 
	#	flash[:notice]: A message indicating the success or failure of the edit
	# Author: Mimi
	def update
		@new_Tip = Hint.find_by_id(hint_params[:id])
		@new_Tip.message = hint_params[:message]
		@new_Tip.submission_counter = hint_params[:submission_counter]
		@model_answer = @new_Tip.model_answer_id
		bool = @new_Tip.save
		if bool == true 
			flash[:notice] = "Hint successfully edited"
			redirect_to :controller => 'model_answers', :action => 'edit',:id => @model_answer
		else
			if @new_Tip.errors.any?
				flash[:notice] = @new_Tip.errors.full_messages.first
			end
			redirect_to :back
		end
	end

 	# [Edit helping hints - Story 4.13 ]
	# Description: 
	#	take the parameters from the from
	# Parameters: none
	# Returns:
	#	Hash of paramas 
	# Author: Mimi
	private
		def hint_params
			params.require(:hint).permit(:message,:submission_counter,:id)
		end
end