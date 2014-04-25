class HintsController < ApplicationController

  	# [View hints and tips-Story 4.22]
	# It fetches from database all the previous hints.
	# Parameters: 
	#	@hints: All the previous hints that had been entered before.
	#	@hints_check: All the previous hints that had been entered before to check if it is a hint or a tip.
	# Returns : none
	# Author: Nadine Adel
	def index
		@hints = Hint.all
		@hints_check = Hints.where(category: false)
	end
end
	
	# [Edit helping hints - Story 4.13 ]
	# This action creates the form and retrives the data of the selected problem 
	#	to be being edited
	# Parameters:
	#	ID of the hint  
	# Returns: none
	# Author: Mimi
	def edit
		if current_lecturer or current_teaching_assistant
		@new_tip = Hint.find_by_id(params[:id])
		else
		render "public/500.html"
		end
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
		@new_tip = Hint.find_by_id(hint_params[:id])
		@new_tip.message = hint_params[:message]
		@new_tip.submission_counter = hint_params[:submission_counter]
		@model_answer = @new_tip.model_answer_id
		bool = @new_tip.save
		if bool == true 
			flash[:notice] = "Hint successfully edited"
			redirect_to :controller => 'model_answers', :action => 'edit', :id => @model_answer
		else
			if @new_tip.errors.any?
				flash[:notice] = @new_tip.errors.full_messages.first
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
			params.require(:hint).permit(:message, :submission_counter, :id)
		end
end

