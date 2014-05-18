class Resource < ActiveRecord::Base

	#Validations
	validates :link, presence: :true

	#Uploader
	mount_uploader :img, ProfileImageUploader

	#Relations
	belongs_to :course
	belongs_to :owner, polymorphic: true

	#Scoops
	
	#Methods

end