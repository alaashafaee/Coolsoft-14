class Student < User
	
	#Validations

	#Relations
	has_many :student_courses
	has_many :courses, through: :student_courses

	has_many :solutions, dependent: :destroy

	has_many :recommended_problems
	has_many :problems, class_name: 'Problem', through: :recommended_problems, source: :problem

	
	#Scoops
	#Methods



end
