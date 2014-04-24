class Post < ActiveRecord::Base
	
	#Validations
	validates :title, :content, presence: true
	
	#Relations
	belongs_to :owner, polymorphic: true
	
	belongs_to :discussion_board, class_name: "DiscussionBoard"
	has_many :replies, dependent: :destroy
	
	#Scoops
	
	#Methods

	def most_recent_reply
  reply = Reply.first(:order => 'created_at DESC', :conditions => ['post_id = ?', self.id])
  return reply
    end


end
