class Topic < ActiveRecord::Base
	
	#Validations

	#Relations
	has_many :tracks, dependent: :destroy

	belongs_to :course
	belongs_to :owner, class_name: "Lecturer", foreign_key: :lecturer_id

	#has_many :progressions, class_name: "TrackProgression"
	
	#Scoops
	#Methods



end
