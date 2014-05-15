class ProblemBankController < ApplicationController
	# [Problem Bank - Story 3.21]
	# Show the Problem bank main page
	# Parameters: none
	# Returns: none
	# Author: Ahmed Sharaf
	def show
	  	@track_id = params[:id]
		@problems = Problem.all
	end

	# [Problem Bank - Story 3.21]
	# Show the problem describtion in a new page
	# Parameters: none
	# Returns: none
	# Author: Ahmed Sharaf
	def index
		@track_id = params[:track_id]
		@problem_id = params[:id]
	end

	# [Problem Bank - Story 3.21]
	# Add the specific problem to the Lecturer/TA
	# Parameters: none
	# Returns: none
	# Author: Ahmed Sharaf
	def add
		@problem = Problem.find_by_id(params[:id])
		@track = Track.find_by_id(params[:track_id])
		@new_problem = @problem.duplicate
		@new_problem.duplicated = true
		if teaching_assistant_signed_in?
			@flag = true
			@track.problems.each do |pr|
				if pr.title == @new_problem.title
					flash[:notice]= @new_problem.title,"You already have this problem"
					@flag = false
				end
			end
			if @flag == true
				@new_problem.track_id = @track.id
				current_teaching_assistant.problems << @new_problem
				flash[:success]= @new_problem.title,"is added successfully"
			end
		elsif lecturer_signed_in?
			@flag = true
			@track.problems.each do |pr| 
				if pr.title == @new_problem.title
					flash[:notice]= @new_problem.title,"You already have this problem"
					@flag = false
	        	end
	        end
	        if @flag == true
		        @new_problem.track_id = @track.id
	        	current_lecturer.problems << @new_problem
	        	flash[:success]= @new_problem.title,"is added successfully"
       		end
		end
		redirect_to :action => 'show', :id => @track.id
	end	
end