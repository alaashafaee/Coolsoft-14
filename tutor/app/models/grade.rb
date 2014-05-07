class Grade < ActiveRecord::Base

	#Validations

	#Relations
	belongs_to :editor, polymorphic: true
	belongs_to :assignment
	belongs_to :problem
	belongs_to :student

	#Scoops

	#Methods

end
