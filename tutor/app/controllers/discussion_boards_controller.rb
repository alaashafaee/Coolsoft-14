class DiscussionBoardsController < ApplicationController

	def toggle
		
		 @id =  params[:id]
		@course = Course.find_by_id(@id)
		 @discussionBoard = @course.discussion_board
		@discussionBoard.activated = !@discussionBoard.activated 
		@discussionBoard.save
		redirect_to :back
	end

	def new
	end


	  def show
	  	@discusstionBoard = DiscussionBoard.find(params[:id])
	  	@posts = @discusstionBoard.posts.order("created_at desc")
	  	@replies = @posts.order("created_at desc")
	  end

end
