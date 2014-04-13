class CoursesController < ApplicationController
	# [Create from Existant Course - Story 2.5]
	# Return the course specified by the id or else return all the courses
	# Parameters:
	#	id: The course id
	# Author: Rania Abdel Fattah 
	def show
		@courses = []
		if(params[:id])
			course = Course.find_by_id(params[:id])
			@courses << course
		else
			@courses = Course.all
		end

	end
	# [Create from Existant Course - Story 2.5]
	# Return all the existing courses
	# Author: Rania Abdel Fattah
	  def existing
	  	@courses = Course.all  
	  end
	# [Create from Existant Course - Story 2.5]
	# Duplicate the courses that it is found and save them in a new coursees
	# Parameters:
	#	id: The course id
	# Author: Rania Abdel Fattah
	 def duplicate
	  	permit
	  	course = Course.find_by_id(params[:Course][:id])
  		newCourse = course.dup
  		newCourse.save
  		redirect_to newCourse
	end
	# [Create from Existant Course - Story 2.5]
	# Choose which parameter should be listed
	# Parameters:
	#	id: The course id
	# Author: Rania Abdel Fattah
	def permit
		params.require(:Course).permit(:id)
	end
end