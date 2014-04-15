class Recommendation < ActiveRecord::Base
	
	#Validations

	#Relations
	belongs_to :student
	belongs_to :problem
	
	#Scoops
	
	#Methods

end
