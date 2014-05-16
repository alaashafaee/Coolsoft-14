class Grade < ActiveRecord::Base

	#Validations

	#Relations
	belongs_to :editor, polymorphic: true
	# belongs_to :assignment
	belongs_to :problem, class_name: "AssignmentProblem"
	belongs_to :student

	#Scoops

	#Methods

end
