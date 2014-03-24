class Stuff < User
	
	#Validations

	#Relations
	has_many :stuff_courses
	has_many :courses, through: :stuff_courses

	has_many :topics
	has_many :tracks
	has_many :problems
	has_many :model_answers
	has_many :method_constraints
	has_many :method_parameters
	has_many :variable_constraints
	has_many :test_cases
	has_many :hints
	
	#Scoops
	#Methods



end
