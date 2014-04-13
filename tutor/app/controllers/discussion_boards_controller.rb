class DiscussionBoardsController < ApplicationController

	def toggle
		@discussionBoard =DiscussionBoard.find_by_id(params[:id])
		@discussionBoard.activated = !@discussionBoard.activated 
		@discussionBoard.save
		redirect_to :back
	end

	def new
	end

	def show
	  	@course = Course.find(params[:id])
	  	@discussionBoard = @course.discussion_board
	  	@posts = @discussionBoard.posts.order("created_at desc")
	  	@replies = @posts.order("created_at desc")
	end
	
end
