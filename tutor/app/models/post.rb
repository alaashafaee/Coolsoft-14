class Post < ActiveRecord::Base

	#Elasticsearch
	include Tire::Model::Search
	include Tire::Model::Callbacks
		
	#Validations
	
	#Relations
	belongs_to :owner, polymorphic: true
	
	belongs_to :discussion_board, class_name: "DiscussionBoard"
	has_many :replies, dependent: :destroy
	
	#Scoops
	
	#Methods

end
