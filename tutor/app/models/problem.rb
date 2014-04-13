class Problem < ActiveRecord::Base
	
	#Validations
	validates_presence_of :title
	validates_presence_of :description
	#Relations
	belongs_to :owner, class_name: 'Staff', foreign_key: :staff_id
	belongs_to :track

	has_many :model_answers, dependent: :destroy
	has_many :test_cases, dependent: :destroy
	has_many :solutions

	#Scoops
	
	#Methods



end
