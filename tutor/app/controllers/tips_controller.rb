class TipsController < ApplicationController

	# [Add tip - Story 4.10]
	# Allows Lecturer/TA to create a tip to help the student_users while solving a problem.
	# Parameters: 
	#   :message is the content of the tip.
	#   :time is a countdown timer that tip will appear after it ends.
	# Returns: @tip : a new created tip to specific answer.
	# Author: Ahmed Osam

	def new
		if(@tip == nil)
			@tip = Hint.new
		end
	end

	def create
		@tip = Hint.new
		@tip.message = tip_params[:message]
		@tip.time = tip_params[:time]
		@tip.category = true
		@tip.model_answer_id = @@answer_id
		if @tip.save
			render :action => 'show'
		else
			render :action=>'new'
		end
	end

	def show
	end

	def index
	end

	def destroy
	end

	def edit
		@tip = Hint.find_by_id(params[:id])
	end

	def update
		@tip = Hint.find(params[:id])
		@tip.category = true
		@tip.time = tip_params_edit[:time]
		@tip.message = tip_params_edit[:message]
		if @tip.save
			render :action => 'show'
		else
			render :action=>'edit'
		end
	end

	private
	def tip_params 
		params.require(:tip).permit(:message, :time)
	end
	private
		def tip_params_edit 
		params.require(:tip_edit).permit(:message, :time)
		end

end