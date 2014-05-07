class Contest < ActiveRecord::Base

	#Validations

	#Relations
	belongs_to :owner, polymorphic: true
	belongs_to :course

	has_many :progress, class_name: 'ContestProgress'
	has_and_belongs_to_many :students, class_name:"Student", join_table: "contests_students"
	has_and_belongs_to_many :problems, join_table: "contests_problems"

	#Scoops
	
	#Methods

end
