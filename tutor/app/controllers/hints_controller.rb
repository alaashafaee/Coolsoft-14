class HintsController < ApplicationController

	@@answer_id = nil

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