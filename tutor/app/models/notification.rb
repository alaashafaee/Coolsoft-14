class Notification < ActiveRecord::Base

	#Validations

	#Relations
	belongs_to :receiver, polymorphic: true

	#Scoops

	#Methods

end
