class CourseStudent < ActiveRecord::Base

	#Validations
	
	#Relations
	belongs_to :course
	belongs_to :student
	#Scoops
	
	#Methods

end
