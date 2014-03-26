class Topic < ActiveRecord::Base
	
	#Validations

	#Relations
	has_many :tracks, dependent: :destroy

	belongs_to :course
	belongs_to :owner, class_name: "Staff", foreign_key: :staff_id

	#Scoops
	#Methods



end
