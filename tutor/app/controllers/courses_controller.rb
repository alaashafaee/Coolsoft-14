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

	# This method get all the existing courses
	# Authored by Rania Abdel Fattah
	  def existing
	  	@courses = Course.all  
	  end

	# This method duplicate the courses that it is found and save it in a new course
	# Authored by Rania Abdel Fattah
	  def duplicate
	  	permit
	  	course = Course.find_by_id(params[:Course][:id])
  		newCourse = course.dup
  		newCourse.save
  		redirect_to newCourse
	end

	# This method choose with parameter should be listed
	# Authored by Rania Abdel Fattah
	def permit
		params.require(:Course).permit(:id)
	end
end