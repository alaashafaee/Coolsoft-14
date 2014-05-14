class AssignmentsController < ApplicationController
  def show
  	session[:course_id] = params[:id]
  		puts "================================sdfdfsd======================"
  	puts params[:id]
  	puts "===============================dssdffds=================="
	@course = Course.find_by_id(session[:id])
	
  end

  def new
  	@course = Course.find_by_id(session[:course_id])
	@new_assignment = Assignment.new	
  end

  def create 
  	@course = Course.find_by_id(session[:course_id])


  	@new_assignment = Assignment.new
  	@new_assignment.title = post_params[:title]
  	@new_assignment.description = post_params[:description]
  	@new_assignment.due_date = post_params[:due_date]
  	@new_assignment.course_id = session[:course_id]
  	
  	if lecturer_signed_in?
			@new_assignment.owner_id = current_lecturer.id
			@new_assignment.owner_type = "lecturer"
		elsif teaching_assistant_signed_in?
			@new_assignment.owner_id = current_teaching_assistant.id
			@new_assignment.owner_type = "teaching assistant"
		end
		if @new_assignment.save
			@course.assignments << @new_assignment
			flash[:success_creation]= "Answer added."
			redirect_to :controller => 'assignment_problems', :action => 'new',
			 :id => @new_assignment.id 
		else
			render :action=>'new', :course_id => params[:course_id]
		end
	end


  def index
  end

  def edit
  end

  private
	def post_params
		params.require(:assignment).permit(:title, :description, :due_date, :year, :day, :month)
	end	
end
