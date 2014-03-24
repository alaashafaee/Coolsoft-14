class Problem < ActiveRecord::Base
	
	#Validations

	#Relations
	belongs_to :owner, class_name: 'Stuff', foreign_key: :stuff_id
	belongs_to :track

	has_many :model_answers, dependent: :destroy

	has_many :recommend_problems
	has_many :recommended_for, class_name: 'Student', through: :recommend_problems, source: :student


	has_many :student_problems, class_name: 'StudentProblems'
	has_many :students, class_name: 'Student', through: :student_problems, source: :student

	#Scoops
	
	#Methods



end
