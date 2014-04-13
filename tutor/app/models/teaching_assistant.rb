class TeachingAssistant < ActiveRecord::Base
	
	#Validations

	#Relations
	has_one :user, as: :sub

	has_and_belongs_to_many :courses, join_table: "courses_teaching_assistants"
	#Scoops
	#Methods



end
