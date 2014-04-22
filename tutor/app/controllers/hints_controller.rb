class HintsController < ApplicationController

    def show
		@new_Tip = Hint.find_by_id(params[:id])
	end
   
    # [Edit helping hints - Story 4.13 ]
	# Description: This action takes the passed parameters from 
	#              the creation form, edits a Hint record
	#              which assigned  to the respective problem. If the 
	#              edit fails the user is redirected to the form
	#              with a "Failed" message.
	# Parameters:
	#	hint_params[]: A list that has all fields entered by the user to in the
	# 					create_topic_form
	# Returns: 
	# 	flash[:notice]: A message indicating the success or failure of the edit
	# Author: Mimi
	def create
		@new_Tip = Hint.find_by_id(params[:id])
		@new_Tip.message = hint_params[:message]
		@new_Tip.submission_counter = hint_params[:submission_counter]
		bool = @new_Tip.save
		if bool == true 
			flash[:notice] = "Hint successfully edited"
			redirect_to :back
		else
			if @new_Tip.errors.any?
			flash[:notice] = @new_Tip.errors.full_messages.first
			end
			#render "create"
			redirect_to :back
		end
	end	

	private
		def hint_params
			params.require(:hint).permit(:message,:submission_counter)
		end
end
