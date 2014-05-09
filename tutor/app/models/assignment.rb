class Assignment < ActiveRecord::Base

	#Validations

	#Relations
	belongs_to :course
	belongs_to :owner, polymorphic: true

	has_many :problems, class_name:"AssignmentProblem", dependent: :destroy

	#Scoops

	#Methods

end
