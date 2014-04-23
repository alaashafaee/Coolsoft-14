class TipsController < ApplicationController
	def new
		if(@tips == nil)
			@tips = Hint.new
		end
	end

	def show
	end

	# [Add tip - Story 4.10]
	# Allows Lecturer/TA to create a tip to help the student_users while solving a problem.
	# Parameters: 
	#   :message is the content of the tip.
	#   :time is a countdown timer that tip will appear after it ends.
	# Returns: @tips : a new created tip to specific answer.
	# Author: Ahmed Osam
	def create
		@tips = Hint.new
		@tips.message = tip_params[:message]
		@tips.time = tip_params[:time]
		@tips.category = true
		if @tips.save
	  		current_lecturer.hints << @tips
	  		@tip = @tips
	  		render :action => 'show'
		else
	  		render :action=>'new'
		end
	end


	def index
	end

	def destroy
	end

	def edit
	end

	def update
	end

  	private
	def tip_params 
		params.require(:tip).permit(:message, :time)
	end

end