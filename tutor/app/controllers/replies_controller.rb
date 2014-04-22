class RepliesController < ApplicationController

	def index
		@replies =  Post.find_by_id(params[:id]).replies
	end

	def show
		@replies =  Reply.find_by_id(params[:id])
		render "index"
	end


	def edit	
		@replies =  Reply.find(params[:id])
		respond_to do |format|
			format.html { render action:"edit"}
        	format.js { render :layout=>false }
   		end
	end

	def new
		line = params[:reply]
		post = Post.find_by_id(params[:post_id])
		reply = Reply.new
		reply.content = line
		post.replies << reply
		if lecturer_signed_in?
			current_lecturer.replies << reply
		elsif teaching_assistant_signed_in?
			current_teaching_assistant.replies << reply
		else
			current_student.replies << reply				
		end
		reply.save
		respond_to do |format|
			format.html { render action:"edit"}
        	format.json { render "new.js"}
        	format.js { render "new"}
   		end

	end

	def destroy
		@reply =  Reply.find(params[:id])
		respond_to do |format|
	        if @reply.destroy
	            format.html { redirect_to action:"index"}
	            format.js 
	        else
	            format.html { render action: "new" }
	            format.js
	        end
	    end

	end

	def update
	    @reply = Reply.find(params[:id])
	    respond_to do |format|
	        if @reply.save
	            format.html { redirect_to "show"}
	            format.js
	        else
	            format.html { render action: "new" }
	        end
	    end
	end

	private
	def reply_params
		params.require(:reply).permit(:content)
	end

end
