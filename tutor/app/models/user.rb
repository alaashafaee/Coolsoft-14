class User < ActiveRecord::Base
	#Validations

	#Relations


	belongs_to :sub, polymorphic: true
	
	#Scoops
	
	#Methods



end
