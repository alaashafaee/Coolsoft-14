class Lecturer < Staff
	
	#Validations

	#Relations
	has_and_belongs_to_many :courses, join_table: "courses_lecturers"
	has_and_belongs_to_many :worked_with, class_name:"TeachingAssistant",join_table: "lecturers_teaching_assistants"

	has_many :topics
	
	#Scoops
	
	#Methods



end
