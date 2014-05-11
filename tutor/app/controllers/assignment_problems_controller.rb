class AssignmentProblemsController < ApplicationController
 def new
  	session[:assignment_id] = params[:id]
  	@assignment =Assignment.find_by_id(session[:assignment_id])
  	
		
	end

def create
  		@assignment =Assignment.find_by_id(session[:assignment_id])
  		@new_problem = AssignmentProblem.new(problem_params)
		if lecturer_signed_in?
			@new_problem.owner_id = current_lecturer.id
			@new_problem.owner_type = "lecturer"
		elsif teaching_assistant_signed_in?
			@new_problem.owner_id = current_teaching_assistant.id
			@new_problem.owner_type = "teaching assistant"
		end
			if @new_problem.save
				@assignment.problems << @new_problem
				redirect_to :controller => 'assignment_problems', :action => 'new',
			 		:id => @assignment.id
			else
				flash.keep[:notice] = "Problem is missing paramaters"
				redirect_to :back
			end
		
  end
  

  	

  def edit
  end

  def show
  end

  def index
  	@assignment =Assignment.find_by_id(session[:assignment_id])
  	  end

  private
		def problem_params
			params.require(:assignment_problem).permit(:title, :description)
		end
end
