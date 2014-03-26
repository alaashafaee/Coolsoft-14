class TestCase < ActiveRecord::Base
	
	#Validations

	#Relations
	belongs_to :model_answer
	belongs_to :owner, class_name: 'Staff', foreign_key: :staff_id

	belongs_to :problem

	
	#Scoops
	#Methods



end
