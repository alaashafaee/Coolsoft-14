class DiscussionBoard < ActiveRecord::Base
	
	#Validations

	#Relations
	belongs_to :course
	has_many :posts, dependent: :destroy
	
	#Scoops
	
	#Methods



end
