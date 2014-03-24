class Student < User
	
	#Validations

	#Relations
	has_many :student_courses
	has_many :courses, through: :student_courses

	has_many :solutions, dependent: :destroy

	has_many :recommend_problems
	has_many :recommended_problems, class_name: 'Problem', through: :recommend_problems, source: :problem

	has_many :student_problems, class_name: 'StudentProblems'
	has_many :problems,  class_name: 'Problem', through: :student_problems, source: :problem

	
	#Scoops
	#Methods



end
