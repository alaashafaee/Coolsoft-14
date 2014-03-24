class DiscussionBoard < ActiveRecord::Base

	#Validations
	validates :title, presence: true, message: "You must Enter the name of the Discussion Board!"

	#Relations
	belongs_to :course
	has_many :posts, dependent: :destroy
	
	#Scoops
	
	#Methods



end
