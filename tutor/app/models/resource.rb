class Resource < ActiveRecord::Base

	#Validations
	validates :description, presence: true
	validates :link, presence: :true

	#Relations
	belongs_to :course
	belongs_to :owner, polymorphic: true
	#Scoops
	
	#Methods

end
