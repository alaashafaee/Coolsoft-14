class DiscussionBoardsController < ApplicationController

	# [Toggle DisscussionBoard - Story 1.10]
	# Description: Activates/Deactivates the status of the discussionBoard
	# Parameters:
	#	params[:id]: The course's discussionBoard id
	# Returns: none
	# Author: Ahmed Atef
	def toggle
		@discussionBoard = DiscussionBoard.find_by_id(params[:id])
		@discussionBoard.activated = !@discussionBoard.activated 
		@discussionBoard.save
		Notification.notify_students_discussion_board(@discussionBoard.id)
		redirect_to :back
	end

	# Description: Displays the problem statment that the user chose
	# Parameters:
	#	@course: The current course the user is in.
	#	@discussionBoard: The discussionBoard of the @course.
	#	@posts = The list of posts of the @discussionBoard
	# Returns: none
	# Author: Ahmed Magdi
	def show
	  	@course = Course.find(params[:id])
	  	@discussionBoard = @course.discussion_board
	  	@posts = @discussionBoard.posts.order("created_at desc")
	  	current_user
	end

	private
	
	# [Design_layout - Story 2.13]
	# Description: Checking the current loged-in user
	# Parameters: none
	# Returns:
	# 	@current_user: The current loged-in user
	# Author: Ahmed Mohamed Magdi
	def current_user
		if student_signed_in?
			@current_user = current_student
		elsif lecturer_signed_in?
			@current_user = current_lecturer
		elsif teaching_assistant_signed_in?
			@current_user = current_teaching_assistant
		end
	end

end
