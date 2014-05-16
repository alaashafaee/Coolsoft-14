class Assignment < ActiveRecord::Base

	#Validations
	validates :title, presence:true

	#Relations
	belongs_to :course
	belongs_to :owner, polymorphic: true

	has_many :problems, class_name:"AssignmentProblem", dependent: :destroy

	#Scoops

	#Methods

end
