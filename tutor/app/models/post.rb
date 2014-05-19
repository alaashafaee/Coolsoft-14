class Post < ActiveRecord::Base
		
	#Elasticsearch
	include Tire::Model::Search
	include Tire::Model::Callbacks

	#Validations
	validates :title, :content, presence: true
	
	#Relations
	belongs_to :owner, polymorphic: true
	
	belongs_to :discussion_board, class_name: "DiscussionBoard"
	has_many :replies, dependent: :destroy
	has_many :tags, as: :tager
	
	#Scoops
	
	#Methods

	def most_recent_reply
		reply = Reply.first(:order => 'created_at DESC',
			:conditions => ['post_id = ?', self.id])
		return reply
	end

	# [Advanced Search - Story 1.23]
	# search for posts
	# Parameters: hash of search options
	# Returns: A hash with search results according to the keyword and other options
	# Author: Ahmed Elassuty
	def self.search(params)
		if params[:keyword].present?
			case params[:options]
				when "exactly match"
					tire.search do
						query { string "title:#{params[:keyword]}" }
					end
				when "includes"
					tire.search do
						query { string "title:*#{params[:keyword]}*" }
					end
				when "starts with"
					tire.search do
						query { string "title:#{params[:keyword]}*" }
					end
				when "ends with"
					tire.search do
						query { string "title:*#{params[:keyword]}" }
					end
			end
		end
	end

end
