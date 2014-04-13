class CoursesController < ApplicationController

	def index
		@courses = current_lecturer.courses.order("created_at desc")
	end  

	def destroy
		course = Course.find_by_id(params[:id])
		course.destroy
		flash[:success] = "Course deleted."
		redirect_to :action => 'index'
	end

	def new
		if(@new_coursedc == nil)
			@new_course = Course.new
		end
	end

	def create
		@new_course  = Course.new
		@new_course.name = course_params[:name]
		@new_course.code = course_params[:code]
		@new_course.year = course_params[:year]
		@new_course.semester = course_params[:semester]
		@new_course.description = course_params[:description]
		if @new_course.save
			current_lecturer.courses << @new_course
			@discussion_board = DiscussionBoard.new
			@discussion_board.title = @new_course.name + " DiscussionBoard"
			@discussion_board.course_id = @new_course.id
			@discussion_board.save
			@new_course.discussion_board = @discussion_board
			flash[:success_creation]= "Course added."
			redirect_to :action => 'index'
		else 
			render :action=>'new'    
		end
	end

	def edit
		@course = Course.find_by_id(params[:id])
		@discussionBoard = @course.discussion_board
	end

	def show
		@course = Course.find_by_id(params[:id])
	end

	def manage
	end

	private 
		def course_params 
			params.require(:course).permit(:name,:code,:year,:semester,:description)
		end

end