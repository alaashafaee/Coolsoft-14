class Problem < ActiveRecord::Base

	#Validations
	validates_presence_of :title
	validates_presence_of :description
	validates_uniqueness_of :title, :scope => :track_id
	#Relations
	belongs_to :owner, polymorphic: true
	belongs_to :track

	has_many :model_answers, dependent: :destroy
	has_many :test_cases, dependent: :destroy
	has_many :solutions, as: :problem
	has_many :attempts, dependent: :destroy
	has_many :problems_start_time, class_name: 'ProblemOpeningTime', dependent: :destroy

	has_many :tags, as: :tager

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

	# [Create Track - Story 4.1]
	# Gets the number of students that has this problem as the status
	# Parameters:
	# 	status: the status that requested (success, failure or incomplete) either true or false
	# Returns: The number of the students
	# Author: Mussab ElDash
	def number_of_attempts_with_status(status)
		query = self.attempts.where(status)
		query = query.select("DISTINCT student_id")
		return query.count
	end

	# [Create Track - Story 4.1]
	# Gets the number of students that has solved this problem successfuly
	# Parameters: none
	# Returns: The number of the students that solved this problem
	# Author: Mussab ElDash
	def number_of_success
		return number_of_attempts_with_status(success: true)
	end

end
