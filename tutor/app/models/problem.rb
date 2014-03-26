class Problem < ActiveRecord::Base
	
	#Validations

	#Relations
	belongs_to :owner, class_name: 'Staff', foreign_key: :staff_id
	belongs_to :track

	has_many :model_answers, dependent: :destroy
	has_many :test_cases, dependent: :destroy
	has_many :solutions

	#Scoops
	
	#Methods
	def is_solved_by_user(user_id)
		return Solution.find_by(
					student_id: user_id,
					problem_id: self.id,
					status: Solution::STATUS_ACCEPTED) != nil
	end
end
