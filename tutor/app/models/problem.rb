class Problem < ActiveRecord::Base
	
	#Validations
	validates_presence_of :title
	validates_presence_of :description

	#Relations
	belongs_to :owner, polymorphic: true
	belongs_to :track

	has_many :model_answers, dependent: :destroy
	has_many :test_cases, dependent: :destroy
	has_many :solutions
	has_many :attempts, dependent: :destroy
	has_many :problems_start_time, class_name: 'ProblemOpeningTime', dependent: :destroy

	#Scoops
	
	#Methods
	# [Find Recommendations - Story 3.9]
	# Checks whether this problem is solved by the target user
	# Parameters: 
	#	user_id: The target user's ID
	# Returns: The boolean value true IFF this problem is solved by the target user, false otherwise
	# Author: Rami Khalil
	def is_solved_by_student(student_id)
		return Solution.find_by(
					student_id: student_id,
					problem_id: self.id,
					status: Solution::STATUS_ACCEPTED) != nil
	end

end
