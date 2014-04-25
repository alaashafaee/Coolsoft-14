class TipsController < ApplicationController

	# [Add tip - Story 4.10]
	# Allows Lecturer/TA to create a tip to help the student_users while solving a problem
	# Parameters: none
	# Returns:
	#	@tip: a new created tip to specific answer
	# Author: Ahmed Osam
	def new
		if(@tip == nil)
			session[:model_answer_id] = params[:model_answer_id]
			@tip = Hint.new
		end
	end
	
	# [Add tip - Story 4.10]
	# Allows Lecturer/TA to create a tip to help the student_users while solving a problem
	# Parameters: 
	#	message: is the content of the tip
	#	time: is a countdown timer that tip will appear after it ends
	#	model_answer_id: is the id of the answer the tip related to
	# Returns:
	#	@tip: a new created tip to specific answer
	# Author: Ahmed Osam
	def create
		@tip = Hint.new
		@tip.message = tip_params[:message]
		@tip.time = tip_params[:time]
		@tip.category = true
		@tip.model_answer_id = session[:model_answer_id]
		@tip.submission_counter = 0
		if lecturer_signed_in?
			@tip.owner_type = "lecturer"
			@tip.owner_id = current_lecturer.id
		elsif teaching_assistant_signed_in?
			@tip.owner_type = "teaching assistant"
			@tip.owner_id = current_teaching_assistant.id
		end
		if @tip.save
			render :action => 'show'
		else
			render :action => 'new'
		end
	end

	# [Show tip - Story 4.23]
	# Show the content of the tip that was created or edited with edit and delete buttons
	# Parameters:
	#	model_answer_id: The model answer id
	#	id: tip id that should be viewed
	# Returns: 
	#	@tip: tip that will be viewed
	# Author: Ahmed Osam
	def show
		@tip = Hint.find_by_id(params[:id])
		redirect_to :controller => 'model_answers', :action => 'edit',
			:model_answer_id => session[:model_answer_id]
	end

	def index
		@tips = Hint.all
		@tips_check = Hint.all
	end

	def destroy
	end

	# [Edit tip - Story 4.10]
	# Finds the tip that wanted to be edited
	# Parameters:
	#	id: id of the tip required to be edited
	# Returns: 
	#	@tip: tip which will be edited
	# Author: Ahmed Osam
	def edit
		@tip = Hint.find_by_id(params[:id])
	end

	# [Edit tip - Story 4.11]
	# update the tip with the new parameters
	# Parameters:
	#	id: id of the tip required to be edited
	#	time: udated time in which tip will be shown after
	#	message: updated content of tip
	# Returns:
	#	@tip: new updated tip
	# Author: Ahmed Osam
	def update
		@tip = Hint.find(params[:id])
		@tip.time = tip_params_edit[:time]
		@tip.message = tip_params_edit[:message]
		if @tip.save
			render :action => 'show'
		else
			render :action => 'edit'
		end
	end

	# [Add tip - Story 4.10]
	# Take information from the form on create tip page
	# Parameters:
	#	tip: name of the form
	#	message: is the content of the tip
	#	time: is a countdown timer that tip will appear after it ends
	# Returns:
	#	none
	# Author: Ahmed Osam
	private
	def tip_params
		params.require(:tip).permit(:message, :time)
	end

	# [Edit tip - Story 4.11]
	# Take new information from a form on edit tip page
	# Parameters:
	#	tip_edit: name of the form
	#	time: udated time in which tip will be shown after
	#	message: updated content of tip
	# Returns:
	#	none
	# Author: Ahmed Osam
	private
	def tip_params_edit 
		params.require(:tip_edit).permit(:message, :time)
	end

end