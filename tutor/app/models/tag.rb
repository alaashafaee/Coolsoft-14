class Tag < ActiveRecord::Base

	#Validations

	#Relations
	belongs_to :tager, polymorphic: true

	#Scoops

	#Methods

end
