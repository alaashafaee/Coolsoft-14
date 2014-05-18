class Grade < ActiveRecord::Base

	#Validations
	validates_presence_of :grade
	validates_presence_of :problem_id
	validates_presence_of :student_id
	#Relations
	belongs_to :editor, polymorphic: true
	# belongs_to :assignment
	belongs_to :problem, class_name: "AssignmentProblem"
	belongs_to :student

	#Scoops

	#Methods

end
