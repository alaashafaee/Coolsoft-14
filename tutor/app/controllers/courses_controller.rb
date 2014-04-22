class CoursesController < ApplicationController

	# Description: This action renders a list of all courses belonging to 
	# 			   the current user.
	# Parameters:
	#	current_lecturer: The current signed in lecturer
	# Returns: 
	# 	@course: A list of all the user's courses
	# Author: Ahmed Osam
	def index
		if lecturer_signed_in?
			@courses = current_lecturer.courses.order("created_at desc")
		elsif teaching_assistant_signed_in?
			@courses = current_teaching_assistant.courses.order("created_at desc")
		else
			@courses = current_student.courses.order("created_at desc")
		end
	end

	# Description: This action takes the course id, remove it from the database
	# 			   and then redirects the user to the show courses page accompanied
	# 			   with a "Course deleted" message.
	# Parameters:
	#	params[:id]: The current course's id
	# Returns: 
	# 	none
	# Author: Mohamed Metawaa
	def destroy
		course = Course.find_by_id(params[:id])
		course.destroy
		flash[:success] = "Course deleted."
		redirect_to :action => 'index'
	end

	# Description: This action creates a new instance variable for the course
	# Parameters:
	#	none
	# Returns: 
	# 	@new_course: A new course instance 
	# Author: Mohamed Mamdouh
	def new
		if(@new_course == nil)
			@new_course = Course.new
		end
	end

	# Description: This action takes the info submited by the user in the form 
	# 			   and creates a new record. Then, insert it in the table. If the 
	# 			   insertion did not succeed, and error message will appear
	# Parameters:
	#	none
	# Returns: 
	# 	none
	# Author: Mohamed Mamdouh
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

	# [Action]
	# Description: This action passes and instance variable of the course and its
	# 			   discussionBoard to the edit view
	# Parameters:
	#	params[:id]: The current course's id
	# Returns: 
	# 	@course
	# 	@discussionBoard
	# Author: Mohamed Mamdouh
	def edit
		@course = Course.find_by_id(params[:id])
		@discussionBoard = @course.discussion_board
	end

	def show
	end

	def manage
	end

	#[Find Recommendations - Story 4.9]
	# Description: This action orders the topics of a specific course
	# Parameters:
	#	params[:id]: The current course's id
	# Returns: none
	# Author: Mohamed Metawaa
	def sort
		@topic = Topic.find_by_id(params[:methodParam][0])  
		@course = @topic.course 
		@topics = @course.topics
		new_Order_Array = params[:methodParam]

		@topics.each do |t|
			t.order_factor = (params[:methodParam]).index(t.id.to_s) + 1 
			t.save
		end
		render :nothing => true
	end

	private
		def course_params 
			params.require(:course).permit(:name,:code,:year,:semester,:description)
		end

end