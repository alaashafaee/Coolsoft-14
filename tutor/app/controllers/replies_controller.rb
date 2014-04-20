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
		respond_to do |format|
		    format.html # new.html.erb
		    format.json { render json: @reply }
		    format.js
	    end
	end

	def edit
		@replies =  Reply.find(params[:id])
		respond_to do |format|
			format.html { render action:"edit"}
        	format.js { render :layout=>false }
   		end
	end

	def create
		@reply = Reply.new(reply_params)
		current_lecturer.replies << @reply
		Post.find_by_id(1).replies << @reply
		respond_to do |format|
			if @reply.save
				format.html { redirect_to action: "index" }
				format.json { render json: @reply, status: :created, location: @reply }
				format.js
			else
				format.html { render action: "new" }
				format.json { render json: @reply.errors, status: :unprocessable_entity }
				format.js
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
