class User < ActiveRecord::Base
	
	#Validations

	#Relations
	has_many :posts, dependent: :destroy
	has_many :replies, dependent: :destroy

	has_many :progressions, class_name: "TrackProgression"
	
	#Scoops
	
	#Methods



end
