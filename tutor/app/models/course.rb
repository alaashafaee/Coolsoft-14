class Course < ActiveRecord::Base
	
	#Validations
	validates :name ,presence: true 
	validates :description , presence: true
	validates :code ,presence: true
	validates :year ,presence: true ,  numericality: { only_integer: true, greater_than_or_equal_to: Date.today.year,message: "is not valid" }
	validates :semester , presence: true , numericality: true

	#Relations
	has_and_belongs_to_many :TAs, class_name:"TeachingAssistant", join_table: "courses_teaching_assistants"
	has_and_belongs_to_many :lecturers, join_table: "courses_lecturers"
	has_and_belongs_to_many :students, join_table: "courses_students"	 
	has_one :discussion_board, dependent: :destroy	
	has_many :topics, dependent: :destroy

	#Scoops
	
	#Methods
	
end
