class Problem < ActiveRecord::Base
	
	#Validations

	#Relations
	belongs_to :owner, class_name: 'Stuff', foreign_key: :stuff_id
	belongs_to :track

	has_many :model_answers, dependent: :destroy

	has_many :recommended_problems
	has_many :recommended_for, class_name: 'Student', through: :recommended_problems, source: :student

	#Scoops
	
	#Methods



end
