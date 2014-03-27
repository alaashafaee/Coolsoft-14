class CoursesController < ApplicationController
	def show
		@courses = []
		if(params[:id])
			course = Course.find_by_id(params[:id])
			@courses << course
		else
			@courses = Course.all
		end

	end


	  def new
	  	@courses = Course.all  
	  end

	  def duplicate
	  	permit
	  	course = Course.find_by_id(params[:Course][:id])
  		newCourse = course.dup
  		newCourse.save
  		redirect_to newCourse
	end

	def permit
		params.require(:Course).permit(:id)
	end
end