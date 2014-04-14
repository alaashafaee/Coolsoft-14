class ProblemsController < ApplicationController
	
	# [Add Problem - 4.4]
	# Creates a new record to Problem Table
	# Parameters: 
	#   title: problem's title through permitCreate action
	#   description: problem's description through permitCreate action
	# Returns: Redirects to edit page on success, refreshes on failure
	# Author: Abdullrahman Elhusseny
	def create
		p = Problem.new(permitCreate)
  		if p.save
  			redirect_to :action => "edit", :id => p.id
		else 
			flash.keep[:notice] = "Problem is missing paramaters"	
			redirect_to :back
		end
	end

	# [Add Problem - 4.4]
	# Passes the input of the form as paramaters for create action to use it
	# Parameters: 
	#   title: problem's title
	#   description: problem's description
	# Returns: params to create action
	# Author: Abdullrahman Elhusseny
	def permitCreate
  		params.require(:Problem).permit(:title , :description) 
  	end

	# [Edit Problem - 4.5]
	# Shows the problem's title and description (Further development is in Sprint 1)
	# Parameters: 
	#   id: The id of the problem to be edited or newly created
	# Returns: Redirects to edit page on success, refreshes on failure
	# Author: Abdullrahman Elhusseny
	def edit
  		@problem = Problem.find_by_id(params[:id])
  	end

  	# [Edit Problem - 4.5]
	# Checks if the user signed in is a lecturer or a TA
	# Parameters: 
	# 	none  
	# Returns: Redirects to add problem page on success, renders error 404 on failure
	# Author: Abdullrahman Elhusseny
  	def new
  		if lecturer_signed_in? || teaching_assistant_signed_in?
  			render ('new')
  		else	
			render ('public/404')
		end	
	end
	
end