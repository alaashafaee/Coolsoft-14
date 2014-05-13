class Note < ActiveRecord::Base

	#Validations
	validates :code, presence: true

	#Relations
	belongs_to :student
	belongs_to :problem, class_name:"Problem", polymorphic: true
	belongs_to :assignment_problem, class_name:"AssignmentProblem", polymorphic: true
	belongs_to :contest_problem, class_name:"Cproblem", polymorphic: true

	#Methods
	
end
