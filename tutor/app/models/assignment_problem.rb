class AssignmentProblem < ActiveRecord::Base

	#Validations
	validates :title, presence:true
	validates :description, presence:true
	validates :final_grade, numericality: { only_integer: true }

	#Relations
	belongs_to :owner, polymorphic: true
	belongs_to :assignment

	has_many :test_cases, dependent: :destroy
	has_many :solutions, as: :problem

	#Scoops

	#Methods

end
