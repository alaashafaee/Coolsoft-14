class Assignment < ActiveRecord::Base

	default_scope order('due_date DESC')
	#Validations
	validates :title, presence:true

	#Relations
	belongs_to :course
	belongs_to :owner, polymorphic: true

	has_many :problems, class_name:"AssignmentProblem", dependent: :destroy

	#Scoops

	#Methods

end
