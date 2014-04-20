class PostsController < ApplicationController


	def new
		@discussion_board = DiscussionBoard.find_by_id(params[:discussion_board_id])
		@new_post = Post.new
	end

	def create
	@new_post = Post.new(post_params)
	#@new_post.content = post_params[:content]
	@new_post.views_count = 0
		if lecturer_signed_in?
			@new_post.owner_id = current_lecturer.id
			@new_post.owner_type = "lecturer"
		elsif teaching_assistant_signed_in?
			@new_post.owner_id = current_teaching_assistant.id
			@new_post.owner_type = "teaching assistant"
			elsif student_signed_in
				@new_post.owner_id = current_student.id
			@new_post.owner_type = "student"
			 	 
		end

		if @new_post.save
			flash[:notice] = "Post successfully created"
			@discussion_board = DiscussionBoard.find_by_id(params[:discussion_board_id])
			@discussion_board.posts << @new_post
	    #		redirect_to :action => 'index'
		else
			if @new_post.errors.any?
				flash[:notice] = @new_post.errors.full_messages.first
			end
			render :action => 'new'  
		end
	end
		private
		def post_params 
			params.permit(:content)
		end
		
end
