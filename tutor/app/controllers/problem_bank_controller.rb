class ProblemBankController < ApplicationController
	def show
	  	@track_id = params[:id]
		@problems = Problem.all
	end

	def index
		@track_id = params[:track_id]
		@problem_id = params[:id]
	end

	def add
		@problem = Problem.find_by_id(params[:id])
		@track = Track.find_by_id(params[:track_id])
		@new_problem = @problem.duplicate
		@new_problem.duplicated = true
		if lecturer_signed_in?
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
		elsif teaching_assistant_signed_in?
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
		end
		redirect_to :action => 'show', :id => @track.id
	end	
end