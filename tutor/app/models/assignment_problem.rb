class AssignmentProblem < ActiveRecord::Base

	#Validations
	validates :title, presence:true

	#Relations
	belongs_to :owner, polymorphic: true
	belongs_to :assignment

	has_many :test_cases, dependent: :destroy
	has_many :solutions, as: :problem

	#Scoops

	#Methods

end
