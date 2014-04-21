class HintsController < ApplicationController
	#t.text     "message"
    #t.boolean  "category"
    #t.integer  "submission_counter"
    #t.integer  "model_answer_id"
    #t.integer  "owner_id"
    #t.string   "owner_type"

	
    def show
		@new_Tip = Problem.find_by_id(params[:id])
	end
   
    # [Edit helping hints - Story 4.13 ]
	# Description: This action takes the passed parameters from 
	#              the creation form, creates a new Hint record
	#              and assigns it to the respective problem. If the 
	#              creation fails the user is redirected to the form
	#              with a "Failed" message.
	# Parameters:
	#	hint_params[]: A list that has all fields entered by the user to in the
	# 					create_topic_form
	# Returns: 
	# 	flash[:notice]: A message indicating the success or failure of the creation
	# Author: Mimi
	def create
		@new_Tip = Hint.new(hint_params)
		@new_Tip.category = false
		bool = @new_Tip.save
		if bool == true 
			flash[:notice] = "Hint successfully created"
			#redirect_to :action => 'create'
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
