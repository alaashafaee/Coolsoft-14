class User < ActiveRecord::Base
	
	#Validations

	#Relations
	has_many :posts, dependent: :destroy
	has_many :replies, dependent: :destroy


	#Scoops
	
	#Methods



end
