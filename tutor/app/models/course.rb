class Course < ActiveRecord::Base
	
	#Validations

	#Relations
	#has_many :TAs, class_name: "TeachingAssistant"
	has_one :discussion_board, dependent: :destroy
	has_many :topics, dependent: :destroy

	
	#Methods



end
