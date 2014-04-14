class Topic < ActiveRecord::Base
	
	#Validations
	validates :title, :description, presence: true

	#Relations
	has_many :tracks, dependent: :destroy
	belongs_to :course
	belongs_to :owner, class_name: "Lecturer", foreign_key: :lecturer_id
	
	#Scoops

	#Methods

	#Methods
	
end
