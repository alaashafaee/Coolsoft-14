class User < ActiveRecord::Base
	#Validations

	#Relations
	has_many :posts, dependent: :destroy
	has_many :replies, dependent: :destroy


	belongs_to :sub, polymorphic: true
	
	#Scoops
	
	#Methods



end
