class RepliesController < ApplicationController

	# Description: fetch all replies from db to view
	# Parameters:
	#	@replies : Containg all the replies
	# Returns: none
	# Author: Ahmed Mohamed Magdi
	def index
		@replies = Post.find_by_id(params[:id]).replies
	end

	# Description: Shows the replies with id
	# Parameters:
	#	@replies: reply with spacific id
	# Returns: none
	# Author: Ahmed Mohamed Magdi
	def show
		@replies = Reply.find_by_id(params[:id])
		render "index"
	end

	# Description: edit reply 
	# Parameters: none
	# Returns: none
	# Author: Ahmed Mohamed Magdi
	def edit	
		@replies = Reply.find(params[:id])
		respond_to do |format|
			format.html { render action:"edit"}
        	format.js { render :layout=>false }
   		end
	end

	# Description: Creates New reply 
	# Parameters:
	#	line: Hash containting the Variables Constraints
	#	method: value of the method name.
	#	method_returned: value of the method return type
	# Returns: none
	# Author: Ahmed Mohamed Magdi
	def create
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
		respond_to do |format|
			if reply.save
				format.html { redirect_to action: "index" }
				format.json { render json: reply, status: :created, location: reply }
				format.js
			else
				format.html { render action: "new" }
				format.json { render json: reply.errors, status: :unprocessable_entity }
				format.js
			end
		end
	end

	# Description: Deleting reply from the database
	#	method_returned: value of the method return type
	# Parameters: 
	# Returns: none
	# Author: Ahmed Mohamed Magdi
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

	# Description: Updating a reply in the database
	# Parameters: none
	# Returns: none
	# Author: Ahmed Mohamed Magdi
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
	# Description: To permit vairble to be saved
	# Parameters:none
	# Returns: none
	# Author: Ahmed Mohamed Magdi
	def reply_params
		params.require(:reply).permit(:content)
	end

end
