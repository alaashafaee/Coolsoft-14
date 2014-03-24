class Course < ActiveRecord::Base
	
	#Validations
	
	#Relations
	has_many :stuff_courses
	has_many :lecturers, class_name: 'Lecturer', through: :stuff_courses, source: :stuff
	has_many :TAs, class_name: 'TeachingAssistant', through: :stuff_courses, source: :stuff
	 
	has_many :student_courses
	has_many :students, through: :student_courses
	
	has_one :discussion_board, dependent: :destroy	
	has_many :topics, dependent: :destroy

	
	#Scoops
	
	#Methods



end
