class StudentCourse < ActiveRecord::Base

	#Validations

	#Relations
	belongs_to :student
	belongs_to :course
	
	#Scoops
	#Methods
	
end
