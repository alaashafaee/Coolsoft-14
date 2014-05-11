class Cproblem < ActiveRecord::Base

	#Validations

	#Relations
	belongs_to :owner, polymorphic: true

	has_many :test_cases, dependent: :destroy
	has_many :solutions, as: :problem
	has_many :contests_progresses, class_name: "ContestProgress"
	has_and_belongs_to_many :contests, join_table: "contests_cproblems"

	#Scoops

	#Methods

end
