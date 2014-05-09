class Tag < ActiveRecord::Base

	#Validations
	validates_presence_of :title
	validates_presence_of :description

	#Relations
	belongs_to :owner, polymorphic: true
	belongs_to :course, polymorphic: true
	belongs_to :problem, polymorphic: true
	belongs_to :post, polymorphic: true

	#Scoops

	#Methods

end
