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
	  	@discusstionBoard = DiscussionBoard.find(params[:id])
	  	@posts = @discusstionBoard.posts.order("created_at desc")
	  	@replies = @posts.order("created_at desc")
	  end

end
