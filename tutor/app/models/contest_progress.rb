class ContestProgress < ActiveRecord::Base

	#Validations

	#Relations
	belongs_to :contest
	belongs_to :student
	belongs_to :problem, class_name: "Cproblem", foreign_key: :problem_id

	#Scoops
	
	#Methods

end
