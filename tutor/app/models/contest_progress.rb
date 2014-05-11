class ContestProgress < ActiveRecord::Base

	#Validations

	#Relations
	belongs_to :contest
	belongs_to :student
	belongs_to :problem, class_name:"Cproblem"

	#Scoops
	
	#Methods

end
