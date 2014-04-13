class DiscussionBoardsController < ApplicationController

	def toggle
		@discussionBoard =DiscussionBoard.find_by_id(params[:id])
		@discussionBoard.activated = !@discussionBoard.activated 
		@discussionBoard.save
		redirect_to :back
	end

	# [Action]
	# Description: This action takes the course id, gets its discussion board and retrieves 
	# 			   all its posts. Then, those posts are passed as an array to the show view.  
	# Author: Ahmed Magdi
	def show
	  	@course = Course.find(params[:id])
	  	@discussionBoard = @course.discussion_board
	  	@posts = @discussionBoard.posts.order("created_at desc")
	  	@replies = @posts.order("created_at desc")
	end

end
