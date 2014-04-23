class Acknowledgement < ActiveRecord::Base
	
	#validatesions
	
	#Relations
	belongs_to :student
	belongs_to :course
	belongs_to :lecturer
	
	#Scoops
	
	#Methods
	
end
