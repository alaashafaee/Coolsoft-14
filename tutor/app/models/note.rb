class Note < ActiveRecord::Base

	#Validations

	#Relations
	belongs_to :owner, polymorphic: true
	belongs_to :problems

	#Methods
	
end
