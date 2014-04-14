class CoursesController < ApplicationController
	# [Create from Existant Course - Story 2.5]
	# Return the courses
	# Author: Rania Abdel Fattah 
	def index
		@courses = Course.all
	end
	# [Create from Existant Course - Story 2.5]
	# Duplicate the courses that it is found and save them in a new course
	# Parameters:
	#	id: The course id
	# Author: Rania Abdel Fattah
	def duplicate
	  	course = Course.find_by_id(permitdup[:id])
  		new_course = course.dup
  		if new_course.save
  			redirect_to :back
  		else
  			redirect_to :back
  		end
	end
	# [Create from Existant Course - Story 2.5]
	# Choose which parameter should be listed
	# Parameters:
	#	id: The course id
	# Author: Rania Abdel Fattah
	private 
		def permitdup
			params.require(:course).permit(:id)
		end
end