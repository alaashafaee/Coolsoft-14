class Track < ActiveRecord::Base
	
	#Validations

	#Relations
	has_many :problems, dependent: :destroy

	belongs_to :topic
	belongs_to :owner, class_name: "Staff", foreign_key: :staff_id
	
	#Scoops
	#Methods



end
