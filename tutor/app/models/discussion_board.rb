class DiscussionBoard < ActiveRecord::Base

	#Validations
	validates :title, presence: true

	#Relations
	belongs_to :course
	has_many :posts, dependent: :destroy

end
