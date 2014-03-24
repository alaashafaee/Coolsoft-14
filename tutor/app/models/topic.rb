class Topic < ActiveRecord::Base
	
	#Validations

	#Relations
	has_many :tracks, dependent: :destroy

	belongs_to :course
	belongs_to :owner, class_name: "Stuff", foreign_key: :stuff_id

	#Scoops
	#Methods



end
