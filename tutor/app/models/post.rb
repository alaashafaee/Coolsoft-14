class Post < ActiveRecord::Base
	
	#Validations
	
	#Relations

	belongs_to :owner, class_name: 'User', foreign_key: :user_id
	belongs_to :discussion_board, class_name: "DiscussionBoard"
	has_many :replies, dependent: :destroy
	
	#Scoops
	
	#Methods



end
