class DiscussionBoardsController < ApplicationController

	 def show
	 #	redirect_to('toggle')
	id = Course.last
		# @id =  params[:id]
	course = Course.find_by_id(id)
	@discussionBoard = course.discussion_board
	 end
	def toggle
		@id = Course.last
		# @id =  params[:id]
		@course = Course.find_by_id(@id)
		@discussionBoard = @course.discussion_board
		@discussionBoard.activated = !@discussionBoard.activated 
		@discussionBoard.save
		redirect_to :back
	end

end
