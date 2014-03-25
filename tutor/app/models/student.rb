class Student < User
	
	#Validations

	#Relations
	# has_many :student_courses
	# has_many :courses, through: :student_courses

	has_many :solutions, dependent: :destroy

	has_many :recommendations
	has_many :recommended_problems, class_name: 'Problem', through: :recommendations, source: :problem
	has_and_belongs_to_many :courses, join_table: 'courses_students'

	
	#Scoops
	#Methods



end
