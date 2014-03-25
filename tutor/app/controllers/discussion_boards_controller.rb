class DiscussionBoardsController < ApplicationController
  def show
  	@discusstionBoard = DiscussionBoard.find(params[:id])
  	@posts = @discusstionBoard.posts.order("created_at desc")
  	@replies = @posts.order("created_at desc")
  end
end
