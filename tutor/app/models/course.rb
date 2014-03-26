class Course < ActiveRecord::Base
	
	#Validations
	
	#Relations
	has_and_belongs_to_many :TAs, class_name:, join_table: "courses_teaching_assistants"
	has_and_belongs_to_many :lecturers, join_table: "courses_lecturers"
	has_and_belongs_to_many :students, join_table: "courses_students"
	 
	has_one :discussion_board, dependent: :destroy	
	has_many :topics, dependent: :destroy

	
	#Scoops
	
	#Methods



end
