class Solution < ActiveRecord::Base
	
	#Validations
	validates :code, presence: true

	#Relations
	belongs_to :student
	belongs_to :problem
	
	#Scoops

	#Methods

	#Constants
	STATUS_SUBMITTED 	= 	0
	STATUS_ACCEPTED		=	1

end
