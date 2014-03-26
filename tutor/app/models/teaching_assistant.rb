class TeachingAssistant < Staff
	
	#Validations

	#Relations
	has_and_belongs_to_many :courses, join_table: "courses_teaching_assistants"

	#Scoops
	#Methods



end
