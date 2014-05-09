class Assignment < ActiveRecord::Base

	#Validations

	#Relations
	belongs_to :course
	belongs_to :owner, polymorphic: true

	has_many :grades, dependent: :destroy
	has_many :problems, class_name:"AssignmentProblem", dependent: :destroy
	has_and_belongs_to_many :students, join_table:"assignments_students"

	#Scoops

	#Methods

end
