class DiscussionBoardsController < ApplicationController

	def toggle
		puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
	    puts " "
	    puts " "
	    puts " "
	    puts params[:id]
	    puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
	    puts " "
	    puts " "
	    puts " "
		@discussionBoard =DiscussionBoard.find_by_id(params[:id])
		@discussionBoard.activated = !@discussionBoard.activated 
		@discussionBoard.save
		redirect_to :back
	end

	def new
	end


	  def show
	  	@course = Course.find(params[:id])
	  	puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
	    puts " "
	    puts " "
	    puts " "
	    puts @course.discussion_board.title
	    puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
	    puts " "
	    puts " "
	    puts " "
	  	@discussionBoard = @course.discussion_board
	  	@posts = @discussionBoard.posts.order("created_at desc")
	  	@replies = @posts.order("created_at desc")
	  end

end
