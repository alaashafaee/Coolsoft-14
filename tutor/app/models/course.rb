class Course < ActiveRecord::Base
	
	#Validations
	validates :name, presence: true 
	validates :description, presence: true
	validates :code, presence: true
	validates :year, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: Date.today.year,
													 message: "is not valid"}
	validates :semester, presence: true, numericality: {only_integer: true, 
		greater_than_or_equal_to: 1,
			message: "is not valid"}

	#Relations
	has_and_belongs_to_many :TAs, class_name:"TeachingAssistant", join_table: "courses_teaching_assistants"
	has_and_belongs_to_many :lecturers, join_table: "courses_lecturers"
	
	has_one :discussion_board, dependent: :destroy	
	has_many :topics, dependent: :destroy
	has_many :acknowledgements, dependent: :destroy

	has_many :course_students
	has_many :students, through: :course_students

	#Scoops
	
	#Methods
	# [Integrating_Akram_Device - Story 4.1]
	# Checks if the user with id :id has the access to edit , create this course
	# Parameters: The id of the user
	# Returns: True in case he has access else False
	# Author: Mussab ElDash
	def can_edit(user)
		if user
			can_edit = user.courses.include?(self)
		else
			false
		end
	end

end
