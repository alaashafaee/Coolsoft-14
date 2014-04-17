class Track < ActiveRecord::Base
	acts_as_list :scope => :topic
	#Validations
	validates :difficulty, presence: true
	validates :title , presence: true

	#Relations
	has_many :problems, dependent: :destroy

	belongs_to :topic	
	belongs_to :owner, polymorphic: true

	#Scoops

	#Methods

end
