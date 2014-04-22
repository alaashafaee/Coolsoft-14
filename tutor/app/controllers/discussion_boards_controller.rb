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
	end

end
