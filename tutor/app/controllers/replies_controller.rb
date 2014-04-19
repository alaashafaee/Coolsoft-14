class RepliesController < ApplicationController

	def index
		@replies =  Post.find_by_id(params[:id]).replies
	end

	def show
		@replies =  Reply.find_by_id(params[:id])
		render "index"
	end

	def new
		@reply = Reply.new()
	end

	def edit
		@replies =  Reply.find(params[:id])
	end

	def create
		@reply = Reply.new(reply_params)
		current_lecturer.replies << @reply
		Post.find_by_id(1).replies << @reply
		respond_to do |format|
	        if @reply.save
	            format.html { render action:"index"}
	            format.js 
	        else
	            format.html { render action: "new" }
	        end
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
